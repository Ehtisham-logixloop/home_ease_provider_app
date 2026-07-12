import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/validation.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../routes/app_routes.dart';
import '../controller/auth_controller.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  final AuthController controller = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Responsive.textM,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Responsive.paddingL),
          child: Form(
            key: controller.signinFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: Responsive.spaceL),

                // TITLE
                Text(
                  "Welcome back !",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                SizedBox(height: Responsive.spaceL),

                // EMAIL
                buildLabel("Email"),
                const SizedBox(height: 6),
                CustomTextField(
                  hint: "Enter email",
                  controller: controller.signinEmail,
                  prefixIcon: Icon(Icons.email, color: AppColors.iconPrimary),
                  validator: Validators.email,
                ),

                SizedBox(height: Responsive.spaceS),
                buildLabel("Password"),
                const SizedBox(height: 6),
                Obx(() {
                  return CustomTextField(
                    hint: "Enter password",
                    controller: controller.signinPassword,
                    prefixIcon: Icon(Icons.lock, color: AppColors.iconPrimary),
                    obscureText: controller.hidePassword.value,
                    validator: Validators.password,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.hidePassword.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.iconSecondary,
                      ),
                      onPressed: controller.togglePassword,
                    ),
                  );
                }),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.forgotPassword);
                    },
                    child: Text("Forgot Password?"),
                  ),
                ),

                SizedBox(height: Responsive.spaceXL),
                Obx(() {
                  return SizedBox(
                    width: double.infinity,
                    height: Responsive.buttonHeight,
                    child: CustomButton(
                      text: controller.isLoading.value
                          ? "Loading..."
                          : "Next",
                        onTap: () async {
                          final form = controller.signinFormKey.currentState;

                          if (form == null || !form.validate()) {
                            Get.snackbar("Error", "Fix all fields");
                            return;
                          }

                          final ok = await controller.signin();

                          if (ok) {
                            Get.offAllNamed(AppRoutes.home);
                          }
                        }
                    ),
                  );
                }),

                SizedBox(height: Responsive.spaceL),
                Center(
                  child: Text(
                    "or continue with",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: Responsive.textS,
                    ),
                  ),
                ),

                SizedBox(height: Responsive.spaceM),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    socialButton("assets/icons/google.png"),
                    socialButton("assets/icons/facebook.png"),
                    socialButton("assets/icons/apple.png"),
                  ],
                ),

                SizedBox(height: Responsive.spaceL),

                Center(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.signup),
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account ? ",
                        children: [
                          TextSpan(
                            text: "SignUp",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: Responsive.spaceL),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialButton(String assetPath) {
    return Container(
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(assetPath),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/validation.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../routes/app_routes.dart';
import '../controller/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

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
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: Responsive.spaceL),

                // TITLE
                Text(
                  "Create an account",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                SizedBox(height: Responsive.spaceL),

                buildLabel("Full Name"),
                SizedBox(height: 3),
                CustomTextField(
                  hint: "Enter your full name",
                  controller: controller.signupName,
                  prefixIcon: Icon(Icons.person, color: AppColors.iconPrimary),
                  validator: Validators.name,
                ),

                SizedBox(height: Responsive.spaceXS),

                // EMAIL
                buildLabel("Email"),
                SizedBox(height: 3),
                CustomTextField(
                  hint: "Enter email",
                  controller: controller.signupEmail,
                  prefixIcon: Icon(Icons.email, color: AppColors.iconPrimary),
                  validator: Validators.email,
                ),

                SizedBox(height: Responsive.spaceXS),

                // PHONE
                buildLabel("Phone"),
                SizedBox(height: 3),
                CustomTextField(
                  hint: "Enter phone",
                  controller: controller.signupPhone,
                  prefixIcon: Icon(Icons.phone, color: AppColors.iconPrimary),
                  validator: Validators.phone,
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: Responsive.spaceXS),

                // PASSWORD
                buildLabel("Password"),
                SizedBox(height: 3),
                Obx(() {
                  return CustomTextField(
                    hint: "Enter password",
                    controller: controller.signupPassword,
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

                SizedBox(height: Responsive.spaceL),

                // BUTTON (LOADING STATE)
                Obx(() {
                  return SizedBox(
                    width: double.infinity,
                    height: Responsive.buttonHeight,
                    child: CustomButton(
                      text: controller.isLoading.value
                          ? "Loading..."
                          : "Next",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.signup();
                          // Get.snackbar(
                          //   "Success",
                          //   "Signup successful",
                          //   backgroundColor: AppColors.success,
                          //   colorText: Colors.white,
                          // );
                          Get.toNamed(AppRoutes.register);
                        } else {
                          Get.snackbar(
                            "Error",
                            "Fix all errors",
                            backgroundColor: AppColors.error,
                            colorText: Colors.white,
                          );
                        }
                      },
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
                    onTap: () => Get.toNamed(AppRoutes.login),
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account ? ",
                        children: [
                          TextSpan(
                            text: "LOGIN",
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_color.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/validation.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../routes/app_routes.dart';
import 'auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final AuthController controller = Get.put(AuthController());
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
                const SizedBox(height: 6),
                CustomTextField(
                  hint: "Enter your full name",
                  controller: controller.signupName,
                  icon: Icons.person,
                  validator: Validators.name,
                ),

                SizedBox(height: Responsive.spaceM),

                // EMAIL
                buildLabel("Email"),
                const SizedBox(height: 6),
                CustomTextField(
                  hint: "Enter email",
                  controller: controller.signupEmail,
                  icon: Icons.email,
                  validator: Validators.email,
                ),

                SizedBox(height: Responsive.spaceM),

                // PHONE
                buildLabel("Phone"),
                const SizedBox(height: 6),
                CustomTextField(
                  hint: "Enter phone",
                  controller: controller.signupPhone,
                  icon: Icons.phone,
                  validator: Validators.phone,
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: Responsive.spaceM),

                // PASSWORD
                buildLabel("Password"),
                const SizedBox(height: 6),
                Obx(() {
                  return CustomTextField(
                    hint: "Enter password",
                    controller: controller.signupPassword,
                    icon: Icons.lock,
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

                          Get.snackbar(
                            "Success",
                            "Signup successful",
                            backgroundColor: AppColors.success,
                            colorText: Colors.white,
                          );
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

                // OR TEXT
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

                // SOCIAL BUTTONS
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
      height: 55,
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Image.asset(assetPath),
      ),
    );
  }
}
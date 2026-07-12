import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controller/auth_controller.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Responsive.paddingL),
            child: Form(
              key: controller.forgotFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Responsive.spaceM),
                  IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: AppColors.iconPrimary),
                    onPressed: () => Get.back(),
                  ),
                  SizedBox(height: Responsive.spaceL),
                  Text(
                    "Forget password",
                    style: TextStyle(
                      fontSize: Responsive.textXXL,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: Responsive.spaceM),
                  Text(
                    "Enter your email or phone number. We will send a code to reset your password.",
                    style: TextStyle(
                      fontSize: Responsive.textM,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: Responsive.spaceXL),
                  Text(
                    "Email or Phone number",
                    style: TextStyle(
                      fontSize: Responsive.textM,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: Responsive.spaceXS),
                  CustomTextField(
                    hint: "Enter email or number",
                    controller: controller.forgotController,
                    prefixIcon: Icon(Icons.email, color: AppColors.iconSecondary),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required field";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: Responsive.spaceXL),
                  Obx(() => SizedBox(
                    width: double.infinity,
                    height: Responsive.buttonHeight,
                    child: CustomButton(
                      text: controller.isLoading.value
                          ? "Please wait..."
                          : "Continue",
                      onTap: controller.isLoading.value
                          ? null
                          : controller.sendOtp,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
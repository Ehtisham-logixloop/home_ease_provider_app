import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/custom_button.dart';
import '../controller/auth_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
              key: controller.otpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: Responsive.spaceM),


                  // 🔙 BACK
                  IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: AppColors.iconPrimary),
                    onPressed: () => Get.back(),
                  ),

                  SizedBox(height: Responsive.spaceL),

                  // TITLE
                  Text(
                    "Enter OTP",
                    style: TextStyle(
                      fontSize: Responsive.textXXL,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: Responsive.spaceS),

                  // DESCRIPTION
                  Text(
                    "Enter the 4 digit code sent to your email or phone",
                    style: TextStyle(
                      fontSize: Responsive.textM,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  SizedBox(height: Responsive.spaceXL),

                  // OTP FIELD
                  PinCodeTextField(
                    appContext: context,
                    controller: controller.otpController,
                    length: 4,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,

                    validator: (value) {
                      if (value == null || value.length < 4) {
                        return "Enter 4 digit code";
                      }
                      return null;
                    },

                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius:
                      BorderRadius.circular(Responsive.cardRadius),
                      fieldHeight: 55,
                      fieldWidth: 55,

                      activeColor: AppColors.primary,
                      selectedColor: AppColors.primary,
                      inactiveColor: AppColors.border,

                      activeFillColor: Colors.white,
                      selectedFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                    ),

                    enableActiveFill: true,

                    onChanged: (value) {},
                  ),

                  SizedBox(height: Responsive.spaceM),

                  // RESEND
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        controller.sendOtp();
                      },
                      child: Text(
                        "Resend Code",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.spaceXL),
                  // BUTTON
                  Obx(() => SizedBox(
                    width: double.infinity,
                    height: Responsive.buttonHeight,
                    child: CustomButton(
                      text: controller.isLoading.value
                          ? "Verifying..."
                          : "Continue",
                      onTap: controller.isLoading.value
                          ? null
                          : controller.verifyOtp,
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/validation.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../controller/auth_controller.dart';
import 'pin_screen.dart';

class SetPassword extends StatefulWidget {
  final bool? isFromProfile;
  const SetPassword({super.key, this.isFromProfile});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  bool obscure1 = true;
  bool obscure2 = true;

  final AuthController controller = Get.find<AuthController>();

  void handleSave() {
    if (widget.isFromProfile == true) {
      // Handle change password
      if (controller.setPasswordFormKey.currentState!.validate()) {
        Get.snackbar("Success", "Password changed successfully!",
            snackPosition: SnackPosition.BOTTOM);
        Get.back();
      }
    } else {
      // Original reset password flow
      controller.resetPassword();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Responsive.paddingM),
          child: Form(
            key: controller.setPasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: Responsive.iconL,
                    color: AppColors.iconPrimary,
                  ),
                  onPressed: () => widget.isFromProfile == true
                      ? Get.back()
                      : Get.off(() => const OtpScreen()),
                ),
                SizedBox(height: Responsive.spaceL),
                Text(
                  widget.isFromProfile == true ? "Change Password" : "New Password",
                  style: TextStyle(
                    fontSize: Responsive.textXXL,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: Responsive.spaceL),
                CustomTextField(
                  hint: "New Password",
                  controller: controller.password,
                  prefixIcon: Icon(Icons.lock_outline, color: AppColors.iconPrimary),
                  obscureText: obscure1,
                  validator: Validators.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure1 ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.iconSecondary,
                    ),
                    onPressed: () => setState(() => obscure1 = !obscure1),
                  ),
                ),
                SizedBox(height: Responsive.spaceM),
                CustomTextField(
                  hint: "Confirm Password",
                  controller: controller.confirmPassword,
                  prefixIcon: Icon(Icons.lock_outline, color: AppColors.iconPrimary),
                  obscureText: obscure2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Required";
                    }
                    if (value != controller.password.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure2 ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.iconSecondary,
                    ),
                    onPressed: () => setState(() => obscure2 = !obscure2),
                  ),
                ),
                SizedBox(height: Responsive.spaceXL),
                CustomButton(
                  text: "Save",
                  onTap: handleSave,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../utils/responsive.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Responsive.buttonHeight,
      child: ElevatedButton(
        onPressed: onTap, // null = disabled
        style: ElevatedButton.styleFrom(
          backgroundColor: onTap == null
              ? Colors.grey
              : AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: Responsive.textL,
            fontWeight: FontWeight.bold,
            color: AppColors.buttonText,
          ),
        ),
      ),
    );
  }
}
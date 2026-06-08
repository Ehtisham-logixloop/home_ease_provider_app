import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../utils/responsive.dart';



class CustomTextField extends StatelessWidget {
  final String? hint;
  final TextEditingController controller;
  final IconData? icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int maxLines;
  final Color? fillColor;
  final bool disableFocusEffect;

  const CustomTextField({
    super.key,
    this.hint,
    required this.controller,
    this.icon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.fillColor,
    this.disableFocusEffect = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = AppColors.border;

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,

      cursorColor: Colors.black,

      decoration: InputDecoration(
        hintText: hint,

        prefixIcon: icon != null
            ? Icon(icon, color: AppColors.iconPrimary)
            : null,

        suffixIcon: suffixIcon,

        filled: true,
        fillColor: fillColor ?? Colors.grey.shade200,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: disableFocusEffect ? borderColor : Colors.blue,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: disableFocusEffect ? borderColor : Colors.blue,
          ),
        ),

        focusColor: Colors.transparent,
        errorStyle: const TextStyle(height: 1), // Optional: tightens up the error text space
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../constants/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.controller,
    this.enabled = true,
    this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          autovalidateMode: autovalidateMode,
          maxLines: maxLines,
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: fillColor != null,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.error),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
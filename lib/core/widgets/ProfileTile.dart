import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? color;

  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color ?? AppColors.iconSecondary),
      title: Text(
        title,
        style: TextStyle(
          fontSize: Responsive.textM,
          color: color ?? AppColors.textPrimary,
        ),
      ),
      trailing: trailing ??
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_color.dart';
import '../../core/utils/responsive.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Get.offNamed(AppRoutes.onboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground
      ,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(Responsive.paddingM),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icons/app_icon.png',
                    width: Responsive.iconXL,
                    height: Responsive.iconXL,
                    color:AppColors.primary,
                  ),
                  SizedBox(height: Responsive.spaceS),
                  Text(
                    'HomeEase',
                    style: TextStyle(
                      fontSize: Responsive.textXL,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: Responsive.spaceXS),
                  Text(
                    'Services',
                    style: TextStyle(
                      fontSize: Responsive.textL,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../../../routes/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(Responsive.paddingL),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.contentWidth,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(height: Responsive.spaceL),

                  // IMAGE
                  Image.asset(
                    "assets/images/on.png",
                    height: 250,
                  ),

                  SizedBox(height: Responsive.spaceM),

                  // TITLE
                  Text(
                    "Solution to make\nyour life easy!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.textXXL,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  SizedBox(height: Responsive.spaceS),

                  // DESCRIPTION
                  Text(
                    "Find the perfect service for your \n home, fast and worry-free",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Responsive.textM,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: Responsive.spaceXL),
                  SizedBox(
                    width: double.infinity,
                    height: Responsive.buttonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Responsive.buttonRadius,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoutes.signup);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: Responsive.textL,
                              fontWeight: FontWeight.bold,
                              color: AppColors.buttonText,
                            ),
                          ),
                          SizedBox(width: Responsive.spaceS),
                          Icon(
                            Icons.arrow_forward,
                            color: AppColors.buttonText,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: Responsive.spaceM),

                  // OUTLINED BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: Responsive.buttonHeight,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Responsive.buttonRadius,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(AppRoutes.login);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: Responsive.textL,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
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
      ),
    );
  }
}
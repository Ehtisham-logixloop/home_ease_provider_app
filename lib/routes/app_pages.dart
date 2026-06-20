import 'package:get/get.dart';


import '../modules/ bindings/HomeBinding.dart';

import '../modules/customer/Customer_Detail_Screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/offerScreen/Offer_Screen.dart';
import '../modules/auth/ForgetScreen.dart';
import '../modules/auth/pin_screen.dart';
import '../modules/auth/register_screen.dart';
import '../modules/auth/set_password_screen.dart';
import '../modules/profile/EditProfileScreen.dart';
import '../modules/auth/sign_in_screen.dart';
import '../modules/auth/sign_up_screen.dart';
import '../modules/onboarding/onboarding_screen.dart';
import '../modules/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [

    GetPage(
      name: AppRoutes.splash,
      page: () =>  SplashScreen(),
    ),

    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
    ),

    GetPage(
      name: AppRoutes.signup,
      page: () => SignupScreen(),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
    ),

    GetPage(
      name: AppRoutes.login,
      page: () => SigninScreen(),
    ),

    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgetScreen(),
    ),

    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpScreen(),
    ),

    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const SetPassword(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: AppRoutes.customerDetail,
      page: () => CustomerDetailScreen(),
    ),

    GetPage(
      name: AppRoutes.createOffer,
      page: () => OfferScreen(),
    ),

    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
    ),

  ];
}
import 'package:get/get.dart';
import '../modules/ bindings/HomeBinding.dart';
import '../modules/MessageScreen/view/ChatScreen.dart';
import '../modules/auth/views/ForgetScreen.dart';
import '../modules/auth/views/pin_screen.dart';
import '../modules/auth/views/register_screen.dart';
import '../modules/auth/views/set_password_screen.dart';
import '../modules/auth/views/sign_in_screen.dart';
import '../modules/auth/views/sign_up_screen.dart';
import '../modules/customer/view/Customer_Detail_Screen.dart';
import '../modules/home/view/home_screen.dart';
import '../modules/offerScreen/view/Offer_Screen.dart';
import '../modules/onboarding/view/onboarding_screen.dart';
import '../modules/profile/views/EditProfileScreen.dart';
import '../modules/splash/view/splash_screen.dart';
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
      page: () =>  EditProfileScreen(),
    ),

    GetPage(
      name: AppRoutes.chat,
      page: () => ChatScreen(thread: Get.arguments),
    ),

  ];
}
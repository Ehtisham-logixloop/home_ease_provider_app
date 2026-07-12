import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modules/auth/controller/auth_controller.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';

void main() {
  // Initialize AuthController permanently so it's not disposed
  Get.put(AuthController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeEase Provider',

      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,

      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
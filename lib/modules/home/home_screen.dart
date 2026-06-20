import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_color.dart';
import '../chatScreen/MessagesScreen.dart';
import '../job/MyJobScreen.dart';
import '../profile/ProfileScreen.dart';
import 'HomeController.dart';
import 'HomeTab.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.find<HomeController>();

  final List<Widget> _screens = [
    const HomeTab(),
    MyJobScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      bottomNavigationBar: _bottomNav(),

      body: SafeArea(
        child: Obx(() {
          return IndexedStack(
            index: controller.currentIndex.value,
            children: _screens,
          );
        }),
      ),
    );
  }

  // ✅ INSIDE CLASS (IMPORTANT FIX)
  Widget _bottomNav() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(0, "Home", "assets/icons/home.png"),
          _navItem(1, "My Job", "assets/icons/job.png"),
          _navItem(2, "Messages", "assets/icons/message.png"),
          _navItem(3, "Profile", "assets/icons/profile.png"),
        ],
      ),
    );
  }

  // ✅ INSIDE CLASS (IMPORTANT FIX)
  Widget _navItem(int index, String label, String iconPath) {
    return Obx(() {
      bool isSelected = controller.currentIndex.value == index;

      return GestureDetector(
        onTap: () => controller.changeTab(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              height: 22,
              color: isSelected ? AppColors.primary : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.primary : Colors.grey,
                fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            )
          ],
        ),
      );
    });
  }
}

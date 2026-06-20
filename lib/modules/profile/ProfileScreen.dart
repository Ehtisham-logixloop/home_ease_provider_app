import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_color.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/ProfileTile.dart';
import '../../modules/auth/set_password_screen.dart';
import '../../routes/app_routes.dart';
import 'ProfileController.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      appBar: AppBar(
        title: const Text("My Profile"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.paddingL),
        child: Column(
          children: [
            SizedBox(height: Responsive.spaceL),
            GestureDetector(
              onTap: () => controller.pickProfileImage(),
              child: Stack(
                children: [
                  Obx(() => CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      backgroundImage: controller.selectedImagePath.value.isNotEmpty
                          ? FileImage(File(controller.selectedImagePath.value)) as ImageProvider
                          : const AssetImage("assets/images/user.png"),
                    ),
                  )),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 18),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: Responsive.spaceL),
            Divider(color: AppColors.border, thickness: 1),
            Expanded(
              child: ListView(
                children: [
                  ProfileTile(
                    icon: Icons.person_outline,
                    title: "Edit Profile",
                    onTap: () => Get.toNamed(AppRoutes.editProfile),
                  ),
                  Divider(color: AppColors.border.withOpacity(0.5)),
                  ProfileTile(
                    icon: Icons.lock_outline,
                    title: "Change Password",
                    onTap: () => Get.to(() => const SetPassword(isFromProfile: true)),
                  ),
                  Divider(color: AppColors.border.withOpacity(0.5)),
                  ProfileTile(
                    icon: Icons.calendar_today_outlined,
                    title: "My Bookings",
                    onTap: () {},
                  ),
                  Divider(color: AppColors.border.withOpacity(0.5)),
                  ProfileTile(
                    icon: Icons.location_on_outlined,
                    title: "My Address",
                    onTap: () {},
                  ),
                  Divider(color: AppColors.border.withOpacity(0.5)),
                  Obx(() => ProfileTile(
                    icon: Icons.dark_mode_outlined,
                    title: "Dark Mode",
                    trailing: Switch(
                      value: controller.isDarkMode.value,
                      onChanged: (val) => controller.toggleDarkMode(val),
                      activeColor: AppColors.primary,
                    ),
                  )),
                  Divider(color: AppColors.border.withOpacity(0.5)),
                  ProfileTile(
                    icon: Icons.privacy_tip_outlined,
                    title: "My Privacy",
                    onTap: () {},
                  ),
                  Divider(color: AppColors.border.withOpacity(0.5)),
                  ProfileTile(
                    icon: Icons.logout,
                    title: "Log out",
                    color: Colors.red,
                    onTap: controller.logout,
                  ),
                  Divider(color: AppColors.border.withOpacity(0.5)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
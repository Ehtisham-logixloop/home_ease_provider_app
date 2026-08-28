import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/ProviderModel.dart';
import '../../../routes/app_routes.dart';
import '../../auth/services/auth_api_service.dart';
import '../services/profile_api_service.dart';

class ProfileController extends GetxController {
  var provider = Rxn<ProviderModel>();
  var isLoading = false.obs;
  var isSaving = false.obs;

  var selectedImagePath = "".obs;
  final ImagePicker _picker = ImagePicker();

  final ProfileApiService _profileApi = ProfileApiService();
  final AuthApiService _authApi = AuthApiService();

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    try {
      isLoading.value = true;
      final result = await _profileApi.fetchProfile();
      if (result != null) {
        provider.value = result;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImagePath.value = image.path;
        await uploadProfileImage(image.path);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick image: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> uploadProfileImage(String filePath) async {
    try {
      isSaving.value = true;
      final result = await _profileApi.uploadProfileImage(filePath: filePath);
      if (result.success) {
        await loadProfileData();
        Get.snackbar(
          "Success",
          result.message.isEmpty ? "Profile image updated" : result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          result.message.isEmpty ? "Upload failed" : result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> updateProfileData(Map<String, dynamic> data) async {
    try {
      isSaving.value = true;
      final result = await _profileApi.updateProfile(data: data);
      if (result.success) {
        await loadProfileData();
        Get.snackbar(
          "Success",
          result.message.isEmpty ? "Profile updated" : result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          result.message.isEmpty ? "Update failed" : result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authApi.logout();
    } catch (_) {}
    Get.offAllNamed(AppRoutes.login);
  }

  var isDarkMode = false.obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }
}
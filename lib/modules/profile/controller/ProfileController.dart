import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/models/ProviderModel.dart';
import '../../../routes/app_routes.dart';

class ProfileController extends GetxController {
  // Use a model for profile data
  var provider = Rxn<ProviderModel>();
  
  // Image picking
  var selectedImagePath = "".obs;
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  void loadProfileData() {
    // Simulating fetching data from API or storage
    provider.value = ProviderModel(
      name: "Abu Bakar",
      role: "Plumber",
      email: "abubakar@example.com",
      phone: "+92 300 1234567",
      rating: "4.8",
      reviews: "120",
      location: "Gujranwala Garden Town",
      profileImage: "assets/images/profile.png",
      jobsDone: "50+",
    );
  }

  Future<void> pickProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImagePath.value = image.path;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  void logout() {
    Get.offAllNamed(AppRoutes.login);
  }

  var isDarkMode = false.obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
    // Implementation removed as requested: just keeping design for now
    // Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }
}
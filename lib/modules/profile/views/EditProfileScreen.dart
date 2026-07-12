import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../controller/ProfileController.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController controller = Get.find<ProfileController>();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController roleController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: controller.provider.value?.name);
    roleController = TextEditingController(text: controller.provider.value?.role);
    emailController = TextEditingController(text: controller.provider.value?.email);
    phoneController = TextEditingController(text: controller.provider.value?.phone);
    locationController = TextEditingController(text: controller.provider.value?.location);
  }

  @override
  void dispose() {
    nameController.dispose();
    roleController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Update provider data
      controller.provider.value = controller.provider.value!.copyWith(
        name: nameController.text,
        role: roleController.text,
        email: emailController.text,
        phone: phoneController.text,
        location: locationController.text,
      );
      Get.snackbar("Success", "Profile updated successfully!",
          snackPosition: SnackPosition.BOTTOM);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Responsive.paddingM),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.spaceL),
                CustomTextField(
                  hint: "Name",
                  controller: nameController,
                  prefixIcon: Icon(Icons.person_outline, color: AppColors.iconSecondary),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.spaceM),
                CustomTextField(
                  hint: "Role / Profession",
                  controller: roleController,
                  prefixIcon: Icon(Icons.work_outline, color: AppColors.iconSecondary),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Role is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.spaceM),
                CustomTextField(
                  hint: "Email",
                  controller: emailController,
                  prefixIcon: Icon(Icons.email_outlined, color: AppColors.iconSecondary),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!GetUtils.isEmail(value)) {
                      return "Invalid email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.spaceM),
                CustomTextField(
                  hint: "Phone Number",
                  controller: phoneController,
                  prefixIcon: Icon(Icons.phone_outlined, color: AppColors.iconSecondary),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Phone is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.spaceM),
                CustomTextField(
                  hint: "Location",
                  controller: locationController,
                  prefixIcon: Icon(Icons.location_on_outlined, color: AppColors.iconSecondary),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Location is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: Responsive.spaceXL),
                CustomButton(
                  text: "Save Changes",
                  onTap: saveProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
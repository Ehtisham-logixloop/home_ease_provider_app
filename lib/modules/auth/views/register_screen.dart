
import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/custom_button.dart';
import '../controller/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthController controller = Get.find<AuthController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Responsive.paddingL),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Responsive.spaceL),
                Center(
                  child: Obx(() {
                    return GestureDetector(
                      onTap: controller.pickImage,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: controller.profileImage.value != null
                                ? FileImage(controller.profileImage.value!)
                                : const AssetImage("assets/images/profile.png") as ImageProvider,
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.camera_alt,
                                  size: 16, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),

                SizedBox(height: Responsive.spaceL),

                const Text("Service Category",
                    style: TextStyle(fontWeight: FontWeight.w600)),

                SizedBox(height: 6),

                Obx(() {
                  return _card(
                    controller.selectedCategory.value,
                    "Select Category",
                    onTap: _openCategorySheet,
                  );
                }),
                SizedBox(height: Responsive.spaceM),
                const Text("CNIC Image",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 6),
                Obx(() {
                  return _uploadCard(
                    title: "Upload CNIC Image",
                    fileName: controller.cnicFile.value?.name,
                    onTap: controller.pickCnicFile,
                  );
                }),
                const Text("Experience",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 6),
                Obx(() {
                  return _uploadCard(
                    title: "Upload Experience Document",
                    fileName: controller.experienceFile.value?.name,
                    onTap: controller.pickExperienceFile,
                  );
                }),

                SizedBox(height: Responsive.spaceM),

                const Text("Police Certification",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 6),
                Obx(() {
                  return _uploadCard(
                    title: "Police Verification Document",
                    fileName: controller.policeFile.value?.name,
                    onTap: controller.pickPoliceFile,
                  );
                }),

                SizedBox(height: Responsive.spaceM),
                const Text("Location",
                    style: TextStyle(fontWeight: FontWeight.w600)),

                SizedBox(height: 6),

                Obx(() {
                  return _card(
                    controller.selectedLocation.value,
                    "Select Location",
                    onTap: _openLocationSheet,
                  );
                }),

                SizedBox(height: Responsive.spaceL),

                Obx(() {
                  return SizedBox(
                    width: double.infinity,
                    height: Responsive.buttonHeight,
                    child: CustomButton(
                      text: controller.isLoading.value
                          ? "Loading..."
                          : "Register",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (controller.validateExtraFields()) {
                            controller.register();
                          }
                        }
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

// ================= CARD =================
  Widget _card(String value, String hint, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value.isEmpty ? hint : value),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

// ================= UPLOAD CARD =================
  Widget _uploadCard({
    required String title,
    String? fileName,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE0E0E0)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                fileName ?? title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.upload_file,color: AppColors.iconPrimary),
          ],
        ),
      ),
    );
  }

// ================= CATEGORY SHEET =================
  void _openCategorySheet() {
    String selected = controller.selectedCategory.value;

    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                const Text(
                  "Service Category",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ...controller.categoryList.map((item) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: _getIcon(item),
                        title: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Radio<String>(
                          value: item,
                          groupValue: selected,
                          onChanged: (value) {
                            setState(() {
                              selected = value!;
                            });
                          },
                        ),
                        onTap: () {
                          setState(() {
                            selected = item;
                          });
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  );
                }),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.setCategory(selected);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }
  Widget _getIcon(String item) {
    switch (item) {
      case "Plumber":
        return Image.asset(
          "assets/icons/google.png",
          width: 24,
          height: 24,
        );

      case "Carpenter":
        return Image.asset(
          "assets/icons/google.png",
          width: 24,
          height: 24,
        );

      case "Electrician":
        return Image.asset(
          "assets/icons/google.png",
          width: 24,
          height: 24,
        );

      case "AC service":
        return Image.asset(
          "assets/icons/google.png",
          width: 24,
          height: 24,
        );

      default:
        return const Icon(Icons.build, size: 24);
    }
  }

// ================= LOCATION SHEET =================
  void _openLocationSheet() {
    Get.bottomSheet(
      Obx(() {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Center(
                child: Text(
                  "Location",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              // ================= PROVINCE =================
              const Text(
                "Choose Province",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              _buildDropdown(
                hint: "Choose province",
                value: controller.selectedProvince.value,
                items: controller.provinces,
                onTap: (value) {
                  controller.loadCities(value);
                },
              ),

              const SizedBox(height: 16),

              // ================= CITY =================
              const Text(
                "Choose City",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              _buildDropdown(
                hint: "Choose city",
                value: controller.selectedCity.value,
                items: controller.cities,
                onTap: (value) {
                  controller.setCity(value);
                },
              ),

              const SizedBox(height: 25),

              // ================= SAVE BUTTON =================
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.setLocation();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      }),
      isScrollControlled: true,
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String value,
    required List<String> items,
    required Function(String) onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value.isEmpty ? null : value,
          hint: Text(hint),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) onTap(val);
          },
        ),
      ),
    );
  }
}


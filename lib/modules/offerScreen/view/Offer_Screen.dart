import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'OfferController.dart';

class OfferScreen extends StatelessWidget {
  OfferScreen({super.key});

  final OfferController controller = Get.put(OfferController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,

      appBar: AppBar(
        title: const Text("My Offer"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Obx(() {

        /// 🔄 LOADING
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.offer.value;

        /// ⚠️ NO DATA
        if (data == null) {
          return const Center(child: Text("No Data Found"));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(Responsive.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 DESCRIPTION
              Text(
                "My Description",
                style: TextStyle(
                  fontSize: Responsive.textL,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: Responsive.spaceM),

              Obx(() {
                return GestureDetector(
                  onTap: controller.enableEdit, // 👈 TAP TO EDIT
                  child: controller.isEditing.value
                      ? CustomTextField(
                          controller: controller.descriptionController,
                          hint: "Enter description",
                          fillColor: AppColors.cardBackground,
                          maxLines: 5,
                        )
                      : Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(Responsive.paddingM),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            data.description,
                            style: TextStyle(
                              fontSize: Responsive.textM,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                );
              }),

              SizedBox(height: Responsive.spaceL),

              /// 🔹 PICTURES
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pictures",
                    style: TextStyle(
                      fontSize: Responsive.textL,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: Responsive.textM,
                    ),
                  ),
                ],
              ),

              SizedBox(height: Responsive.spaceM),

              /// 🔹 IMAGES
              SizedBox(
                height: 120,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.images.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(width: Responsive.spaceM),
                  itemBuilder: (context, index) {
                    final img = data.images[index];

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        img,
                        width: 150,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 150,
                          height: 120,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.broken_image),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: Responsive.spaceL),

              /// 🔹 AMOUNT
              Text(
                "Offer Amount",
                style: TextStyle(
                  fontSize: Responsive.textL,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: Responsive.spaceM),

              Obx(() {
                return GestureDetector(
                  onTap: controller.enableEdit,
                  child: controller.isEditing.value
                      ? CustomTextField(
                          controller: controller.amountController,
                          hint: "Enter amount",
                          keyboardType: TextInputType.number,
                          fillColor: AppColors.cardBackground,
                        )
                      : Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(Responsive.paddingM),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Rs. ${data.amount}",
                      style: TextStyle(
                        fontSize: Responsive.textL,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: Responsive.spaceXL),
              CustomButton(
                text: "Send Offer",
                onTap: controller.sendOffer,
              ),
            ],
          ),
        );
      }),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_color.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/custom_button.dart';
import '../offerScreen/Offer_Screen.dart';
import '../../routes/app_routes.dart';
import 'CustomerDetailController.dart';

class CustomerDetailScreen extends StatelessWidget {
  CustomerDetailScreen({super.key});

  final controller = Get.put(CustomerDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text("Customer Detail"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),

      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = controller.customer.value;
        if (data == null) {
          return const Center(child: Text("No Data Found"));
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(Responsive.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _field("Name", data.name),
              _field("Sub Category", data.subCategory),
              _multiField("Problem Description", data.description),
              SizedBox(height: Responsive.spaceM),
              const Text(
                "Pictures",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: Responsive.spaceS),
              Row(
                children: data.images
                    .map((img) => Expanded(child: _image(img)))
                    .toList(),
              ),
              SizedBox(height: Responsive.spaceM),
              _field("Amount", "Rs. ${data.amount}"),
              _field("Date", data.date),
              _field("Time", data.time),
              _location(data.location),
              SizedBox(height: Responsive.spaceXL),
              CustomButton(
                text: "Create Offer",
                onTap: () {
                  Get.toNamed(AppRoutes.createOffer, arguments: data);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
  Widget _field(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Responsive.paddingS),
          margin: EdgeInsets.only(bottom: Responsive.spaceM),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(value),
        ),
      ],
    );
  }
  Widget _multiField(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 6),
        Container(
          height: 100,
          width: double.infinity,
          padding: EdgeInsets.all(Responsive.paddingS),
          margin: EdgeInsets.only(bottom: Responsive.spaceM),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(value),
        ),
      ],
    );
  }
  Widget _image(String img) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  Widget _location(String value) {
    return Container(
      margin: EdgeInsets.only(top: Responsive.spaceM),
      padding: EdgeInsets.all(Responsive.paddingS),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: AppColors.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
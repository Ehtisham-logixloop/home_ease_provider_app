import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/RequestModel.dart';
import '../controller/HomeController.dart';



class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// PROFILE HEADER
          Row(
            children: [
              const CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),
              SizedBox(width: Responsive.spaceM),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Abu Bakar",
                        style: TextStyle(
                            fontSize: Responsive.textL,
                            fontWeight: FontWeight.bold)),

                    Text("Plumber",
                        style: TextStyle(color: AppColors.textSecondary)),

                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 16, color: AppColors.primary),
                        SizedBox(width: 4),
                        Text("Gujranwala Garden Town",
                            style: TextStyle(color: AppColors.textSecondary)),
                      ],
                    ),
                  ],
                ),
              ),

              Obx(() {
                return Switch(
                  value: controller.isOnline.value,
                  onChanged: controller.toggleOnline,
                );
              })
            ],
          ),

          SizedBox(height: Responsive.spaceL),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Incoming Requests",
                  style: TextStyle(
                      fontSize: Responsive.textXL,
                      fontWeight: FontWeight.bold)),
              Text("View all",
                  style: TextStyle(color: AppColors.primary))
            ],
          ),

          SizedBox(height: Responsive.spaceM),

          /// REQUEST LIST
          Obx(() {
            return Column(
              children: controller.requests
                  .map((e) => _requestCard(e, controller))
                  .toList(),
            );
          }),

          SizedBox(height: Responsive.spaceL),

          /// EARNING
          Text("Earning Overview",
              style: TextStyle(
                  fontSize: Responsive.textXL,
                  fontWeight: FontWeight.bold)),

          SizedBox(height: Responsive.spaceM),

          Container(
            padding: EdgeInsets.all(Responsive.paddingM),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _earning("Rs 1130", "Today"),
                _line(),
                _earning("Rs 3400", "This Week"),
                _line(),
                _earning("10", "Jobs"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _requestCard(RequestModel item, HomeController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.spaceM),
      padding: EdgeInsets.all(Responsive.paddingM),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.png"),
              ),
              SizedBox(width: Responsive.spaceM),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),

                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 14),
                        Expanded(child: Text(item.location)),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star,
                            size: 16, color: Colors.orange),
                        Text(" ${item.rating}"),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const Text("PKR"),
                  Text(item.price,
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),

          SizedBox(height: Responsive.spaceM),
          const Text("Description",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text(item.desc),
          SizedBox(height: Responsive.spaceM),
          Row(
            children: [
              Expanded(child: _btn("Decline", Colors.grey)),

              const SizedBox(width: 10),

              Expanded(
                child: GestureDetector(
                  onTap: () => controller.openRequestDetail(item),
                  child: _btn("Detail", AppColors.primary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget _btn(String text, Color color) {
    return Container(
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text,
          style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _earning(String val, String label) {
    return Column(
      children: [
        Text(val, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label),
      ],
    );
  }

  Widget _line() {
    return Container(width: 1, height: 40, color: AppColors.border);
  }
}
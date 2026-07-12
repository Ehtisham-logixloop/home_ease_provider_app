import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../../../routes/app_routes.dart';
import '../controller/MessageController.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({super.key});

  final controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "All Messages",
          style: TextStyle(color: AppColors.textPrimary),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.scaffoldBackground,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Responsive.paddingM),
            child: TextField(
              controller: controller.searchController,
              onChanged: controller.search,
              decoration: InputDecoration(
                hintText: "Search here",
                hintStyle: TextStyle(color: AppColors.textSecondary),
                prefixIcon: Icon(Icons.search, color: AppColors.iconSecondary),
                filled: true,
                fillColor: AppColors.cardBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Responsive.cardRadius),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Responsive.paddingM,
                  vertical: Responsive.paddingS,
                ),
              ),
            ),
          ),

          /// 📩 LIST
          Expanded(
            child: Obx(() {
              return ListView.separated(
                itemCount: controller.filteredMessages.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: AppColors.border,
                ),
                itemBuilder: (context, index) {
                  final msg = controller.filteredMessages[index];

                  return ListTile(
                    onTap: () => Get.toNamed(AppRoutes.chat, arguments: msg),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: Responsive.paddingM,
                      vertical: Responsive.paddingS,
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(msg.image),
                      radius: Responsive.isMobile ? 28 : 32,
                    ),

                    title: Text(
                      msg.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontSize: Responsive.textM,
                      ),
                    ),

                    subtitle: Text(
                      msg.lastMessage,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: Responsive.textS,
                      ),
                    ),

                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          msg.time,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: Responsive.textS,
                          ),
                        ),

                        SizedBox(height: Responsive.spaceXS),

                        if (msg.unreadCount > 0)
                          Container(
                            padding: EdgeInsets.all(Responsive.paddingXS),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              msg.unreadCount.toString(),
                              style: TextStyle(
                                color: AppColors.buttonText,
                                fontSize: Responsive.textXS,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
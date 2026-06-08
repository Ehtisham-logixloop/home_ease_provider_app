import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'MessageController.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({super.key});

  final controller = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Messages"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: controller.searchController,
              onChanged: controller.search,
              decoration: InputDecoration(
                hintText: "Search here",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          /// 📩 LIST
          Expanded(
            child: Obx(() {
              return ListView.separated(
                itemCount: controller.filteredMessages.length,
                separatorBuilder: (_, __) =>
                const Divider(height: 1),
                itemBuilder: (context, index) {
                  final msg = controller.filteredMessages[index];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(msg.image),
                      radius: 28,
                    ),

                    title: Text(
                      msg.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(msg.lastMessage),

                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(msg.time),

                        const SizedBox(height: 5),

                        if (msg.unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              msg.unreadCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
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
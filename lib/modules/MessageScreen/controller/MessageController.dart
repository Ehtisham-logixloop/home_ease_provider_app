import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/MessageThread.dart';


class MessageController extends GetxController {

  RxList<MessageThread> messages = <MessageThread>[].obs;
  RxList<MessageThread> filteredMessages = <MessageThread>[].obs;

  final searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  void loadMessages() {
    final data = [
      MessageThread(
        name: "Saad Mughal (Carpenter)",
        role: "",
        lastMessage: "ok boss",
        time: "14:32",
        image: "https://i.pravatar.cc/150?img=1",
        unreadCount: 2,
      ),
      MessageThread(
        name: "Ehtsham (Electrician)",
        role: "",
        lastMessage: "I'll be there in 2 mins",
        time: "12:32",
        image: "https://i.pravatar.cc/150?img=2",
        unreadCount: 2,
      ),
      MessageThread(
        name: "Minahil Shafiq (Beautition)",
        role: "",
        lastMessage: "Hey bro!",
        time: "01:42",
        image: "https://i.pravatar.cc/150?img=3",
        unreadCount: 2,
      ),
      MessageThread(
        name: "Samiullah (Cleaner)",
        role: "",
        lastMessage: "woohoooo",
        time: "01:22",
        image: "https://i.pravatar.cc/150?img=4",
      ),
      MessageThread(
        name: "Naveed (Painter)",
        role: "",
        lastMessage: "How are you?",
        time: "Mon, 22:23",
        image: "https://i.pravatar.cc/150?img=5",
      ),
    ];

    messages.assignAll(data);
    filteredMessages.assignAll(data);
  }

  void search(String value) {
    if (value.isEmpty) {
      filteredMessages.assignAll(messages);
    } else {
      filteredMessages.assignAll(
        messages.where((e) =>
            e.name.toLowerCase().contains(value.toLowerCase())).toList(),
      );
    }
  }
}
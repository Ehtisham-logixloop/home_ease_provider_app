import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../data/models/MessageThread.dart';
import '../services/message_api_service.dart';

class MessageController extends GetxController {

  RxList<MessageThread> messages = <MessageThread>[].obs;
  RxList<MessageThread> filteredMessages = <MessageThread>[].obs;
  RxBool isLoading = false.obs;

  final searchController = TextEditingController();

  final MessageApiService _api = MessageApiService();

  @override
  void onInit() {
    super.onInit();
    loadMessages();
  }

  Future<void> loadMessages() async {
    try {
      isLoading.value = true;
      final result = await _api.fetchMessageThreads();
      if (result.isNotEmpty) {
        messages.assignAll(result);
        filteredMessages.assignAll(result);
      }
    } finally {
      isLoading.value = false;
    }
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
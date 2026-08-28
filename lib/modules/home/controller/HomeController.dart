import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/RequestModel.dart';
import '../../../routes/app_routes.dart';
import '../services/home_api_service.dart';

class HomeController extends GetxController {

  var isOnline = true.obs;
  var isLoading = false.obs;
  var isTogglingOnline = false.obs;

  var requests = <RequestModel>[].obs;
  var currentIndex = 0.obs;

  final HomeApiService _api = HomeApiService();

  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  Future<void> toggleOnline(bool value) async {
    isTogglingOnline.value = true;
    try {
      final result = await _api.toggleOnline(isOnline: value);
      if (result.success) {
        isOnline.value = value;
      } else {
        Get.snackbar(
          "Error",
          result.message.isEmpty
              ? "Failed to update status"
              : result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isTogglingOnline.value = false;
    }
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void openRequestDetail(RequestModel item) {
    Get.toNamed(AppRoutes.customerDetail, arguments: item);
  }

  Future<void> fetchRequests() async {
    try {
      isLoading.value = true;
      final result = await _api.fetchRequests();
      if (result.isNotEmpty) {
        requests.value = result;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
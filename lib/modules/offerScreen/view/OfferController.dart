import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/OfferModel.dart';
import '../../../data/models/RequestModel.dart';
import '../services/offer_api_service.dart';

class OfferController extends GetxController {

  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;
  RxBool isSending = false.obs;

  Rxn<OfferModel> offer = Rxn<OfferModel>();

  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  final OfferApiService _api = OfferApiService();

  String? _requestId;

  @override
  void onInit() {
    super.onInit();

    final data = Get.arguments;

    if (data is OfferModel) {
      offer.value = OfferModel(
        description: data.description,
        amount: data.amount,
        images: data.images,
      );
      descriptionController.text = data.description;
      amountController.text = data.amount.toString();
    } else if (data is RequestModel) {
      descriptionController.text = data.desc;
      amountController.text = data.price;
    } else if (data is Map) {
      if (data['requestId'] != null) {
        _requestId = data['requestId'].toString();
      }
      if (data['description'] != null) {
        descriptionController.text = data['description'].toString();
      }
      if (data['amount'] != null) {
        amountController.text = data['amount'].toString();
      }
    }
  }

  void enableEdit() {
    isEditing.value = true;
  }

  Future<void> saveEdit() async {
    final data = offer.value;
    if (data == null) return;

    final newDesc = descriptionController.text.trim();
    final newAmount = int.tryParse(amountController.text.trim()) ?? 0;

    offer.value = data.copyWith(
      description: newDesc,
      amount: newAmount,
    );

    isEditing.value = false;
  }

  Future<void> sendOffer() async {
    final description = descriptionController.text.trim();
    final amount = int.tryParse(amountController.text.trim()) ?? 0;

    if (description.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a description",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (amount <= 0) {
      Get.snackbar(
        "Error",
        "Please enter a valid amount",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isSending.value = true;
      final result = await _api.sendOffer(
        requestId: _requestId ?? '',
        description: description,
        amount: amount,
        images: offer.value?.images ?? [],
      );

      if (result.success) {
        Get.snackbar(
          "Success",
          result.message.isEmpty ? "Offer Sent" : result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          result.message.isEmpty ? "Failed to send offer" : result.message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isSending.value = false;
    }
  }

  @override
  void onClose() {
    descriptionController.dispose();
    amountController.dispose();
    super.onClose();
  }
}
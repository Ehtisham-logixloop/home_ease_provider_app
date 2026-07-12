import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/OfferModel.dart';

class OfferController extends GetxController {

  RxBool isLoading = false.obs;
  RxBool isEditing = false.obs;

  Rxn<OfferModel> offer = Rxn<OfferModel>();

  /// ✅ same names as UI
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    final data = Get.arguments;

    if (data != null) {
      offer.value = OfferModel(
        description: data.description,
        amount: int.tryParse(data.amount.toString()) ?? 0,
        images: data.images,
      );

      descriptionController.text = data.description;
      amountController.text = data.amount.toString();
    }
  }

  /// ✏️ enable edit
  void enableEdit() {
    isEditing.value = true;
  }

  /// 💾 save edit
  void saveEdit() {
    final data = offer.value;
    if (data == null) return;

    offer.value = data.copyWith(
      description: descriptionController.text,
      amount: int.tryParse(amountController.text) ?? 0,
    );

    isEditing.value = false;
  }

  void sendOffer() {
    Get.snackbar("Success", "Offer Sent");
  }

  @override
  void onClose() {
    descriptionController.dispose();
    amountController.dispose();
    super.onClose();
  }
}
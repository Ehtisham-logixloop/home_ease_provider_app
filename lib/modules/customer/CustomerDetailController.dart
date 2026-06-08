import 'package:get/get.dart';
import 'dart:convert';
import '../../data/models/CustomerDetailModel.dart';


class CustomerDetailController extends GetxController {

  var isLoading = false.obs;
  var customer = Rxn<CustomerDetailModel>();

  @override
  void onInit() {
    super.onInit();
    fetchCustomerDetail();
  }

  Future<void> fetchCustomerDetail() async {
    try {
      isLoading.value = true;

      /// 🔥 FAKE API RESPONSE (replace with real API)
      await Future.delayed(const Duration(seconds: 2));

      final response = {
        "name": "Saad Mughal",
        "sub_category": "Plumber",
        "description":
        "I want repair my washroom shower and install tap...",
        "amount": "1500",
        "date": "Sep, 13, 2025",
        "time": "11.00 AM",
        "location": "Sialkot road Street no 4.. house no 16",
        "images": [
          "assets/images/tap.jpg",
          "assets/images/sink.jpg"
        ]
      };

      customer.value = CustomerDetailModel.fromJson(response);

    } finally {
      isLoading.value = false;
    }
  }
}
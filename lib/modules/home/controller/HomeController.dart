import 'package:get/get.dart';
import '../../../data/models/RequestModel.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {

  var isOnline = true.obs;
  var isLoading = false.obs;

  var requests = <RequestModel>[].obs;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void toggleOnline(bool value) {
    isOnline.value = value;
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void loadDummyData() {
    requests.value = [
      RequestModel(
        name: "Saad Mughal",
        location: "Sialkot road street no 4...",
        rating: "4.4",
        price: "1500",
        desc: "It is a long established fact that a reader will be distracted...",
      ),
      RequestModel(
        name: "Ali Khan",
        location: "Gujranwala Garden Town",
        rating: "4.2",
        price: "1200",
        desc: "Professional service with quality work...",
      ),
    ];
  }
  void openRequestDetail(RequestModel item) {
    Get.toNamed(AppRoutes.customerDetail, arguments: item);
  }
  Future<void> fetchRequests() async {
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(seconds: 2));

      // API later:
      // requests.value = response.map((e) => RequestModel.fromJson(e)).toList();

    } finally {
      isLoading.value = false;
    }
  }
}
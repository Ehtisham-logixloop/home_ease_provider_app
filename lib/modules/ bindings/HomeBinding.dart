import 'package:get/get.dart';

import '../home/controller/HomeController.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }
}
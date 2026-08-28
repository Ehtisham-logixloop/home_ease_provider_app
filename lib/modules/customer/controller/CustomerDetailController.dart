import 'package:get/get.dart';
import '../../../data/models/CustomerDetailModel.dart';
import '../../../data/models/RequestModel.dart';
import '../services/customer_api_service.dart';

class CustomerDetailController extends GetxController {

  var isLoading = false.obs;
  var customer = Rxn<CustomerDetailModel>();

  final CustomerApiService _api = CustomerApiService();

  @override
  void onInit() {
    super.onInit();
    fetchCustomerDetail();
  }

  Future<void> fetchCustomerDetail() async {
    try {
      isLoading.value = true;

      final args = Get.arguments;
      String? requestId;

      if (args is RequestModel) {
        requestId = args.runtimeType.toString().contains('RequestModel')
            ? null
            : null;
      } else if (args is String) {
        requestId = args;
      } else if (args is Map && args['requestId'] != null) {
        requestId = args['requestId'].toString();
      }

      if (requestId != null) {
        final result = await _api.fetchCustomerDetail(requestId);
        if (result != null) {
          customer.value = result;
          return;
        }
      }

      customer.value = CustomerDetailModel(
        name: args is RequestModel ? args.name : 'Customer',
        subCategory: '',
        description:
            args is RequestModel ? args.desc : 'Service requested',
        amount: args is RequestModel ? args.price : '0',
        date: '',
        time: '',
        location: args is RequestModel ? args.location : '',
        images: [],
      );
    } finally {
      isLoading.value = false;
    }
  }
}
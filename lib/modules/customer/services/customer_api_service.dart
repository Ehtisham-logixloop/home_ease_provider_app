import '../../../core/constants/api_constants.dart';
import '../../../core/network/base_api_client.dart';
import '../../../data/models/CustomerDetailModel.dart';

class CustomerApiService {
  static final CustomerApiService _instance = CustomerApiService._internal();
  factory CustomerApiService() => _instance;
  CustomerApiService._internal();

  final BaseApiClient _client = BaseApiClient();

  Future<CustomerDetailModel?> fetchCustomerDetail(String requestId) async {
    final response = await _client.get(
      '${ApiConstants.requestDetail}/$requestId',
      requireAuth: true,
    );

    if (response.success) {
      return response.parseObject<CustomerDetailModel>(CustomerDetailModel.fromJson);
    }
    return null;
  }
}

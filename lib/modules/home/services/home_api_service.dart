import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/base_api_client.dart';
import '../../../data/models/RequestModel.dart';

class HomeApiService {
  static final HomeApiService _instance = HomeApiService._internal();
  factory HomeApiService() => _instance;
  HomeApiService._internal();

  final BaseApiClient _client = BaseApiClient();

  Future<List<RequestModel>> fetchRequests({String? status}) async {
    final response = await _client.get(
      ApiConstants.requests,
      queryParams: {
        if (status != null) 'status': status,
      },
      requireAuth: true,
    );

    if (response.success) {
      return response.parseList<RequestModel>(RequestModel.fromJson);
    }
    return <RequestModel>[];
  }

  Future<ApiResponse> toggleOnline({required bool isOnline}) async {
    return _client.post(
      ApiConstants.toggleOnline,
      requireAuth: true,
      body: {
        'isOnline': isOnline,
        'online': isOnline,
      },
    );
  }

  Future<RequestModel?> fetchRequestDetail(String requestId) async {
    final response = await _client.get(
      '${ApiConstants.requestDetail}/$requestId',
      requireAuth: true,
    );

    if (response.success) {
      return response.parseObject<RequestModel>(RequestModel.fromJson);
    }
    return null;
  }
}

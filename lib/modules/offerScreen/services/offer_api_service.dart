import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/base_api_client.dart';
import '../../../data/models/OfferModel.dart';

class OfferApiService {
  static final OfferApiService _instance = OfferApiService._internal();
  factory OfferApiService() => _instance;
  OfferApiService._internal();

  final BaseApiClient _client = BaseApiClient();

  Future<ApiResponse> sendOffer({
    required String requestId,
    required String description,
    required int amount,
    List<String>? images,
  }) async {
    return _client.post(
      ApiConstants.sendOffer,
      requireAuth: true,
      body: {
        'requestId': requestId,
        'description': description,
        'amount': amount,
        if (images != null) 'images': images,
      },
    );
  }

  Future<ApiResponse> updateOffer({
    required String offerId,
    required String description,
    required int amount,
  }) async {
    return _client.put(
      '${ApiConstants.updateOffer}/$offerId',
      requireAuth: true,
      body: {
        'description': description,
        'amount': amount,
      },
    );
  }

  Future<OfferModel?> fetchOffer(String offerId) async {
    final response = await _client.get(
      '${ApiConstants.offers}/$offerId',
      requireAuth: true,
    );

    if (response.success) {
      return response.parseObject<OfferModel>(OfferModel.fromJson);
    }
    return null;
  }
}

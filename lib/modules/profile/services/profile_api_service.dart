import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/base_api_client.dart';
import '../../../data/models/ProviderModel.dart';

class ProfileApiService {
  static final ProfileApiService _instance = ProfileApiService._internal();
  factory ProfileApiService() => _instance;
  ProfileApiService._internal();

  final BaseApiClient _client = BaseApiClient();

  Future<ProviderModel?> fetchProfile() async {
    final response = await _client.get(
      ApiConstants.profile,
      requireAuth: true,
    );

    if (response.success) {
      return response.parseObject<ProviderModel>(ProviderModel.fromJson);
    }
    return null;
  }

  Future<ApiResponse> updateProfile({
    required Map<String, dynamic> data,
  }) async {
    return _client.put(
      ApiConstants.updateProfile,
      requireAuth: true,
      body: data,
    );
  }

  Future<ApiResponse> uploadProfileImage({
    required String filePath,
  }) async {
    return _client.multipartPost(
      ApiConstants.uploadProfileImage,
      requireAuth: true,
      files: [
        MultipartFileItem(
          field: 'profileImage',
          filePath: filePath,
          mimeType: 'image/jpeg',
        ),
      ],
    );
  }

  Future<ApiResponse> uploadDocuments({
    String? cnicPath,
    String? experiencePath,
    String? policePath,
  }) async {
    final files = <MultipartFileItem>[];
    if (cnicPath != null) {
      files.add(MultipartFileItem(
        field: 'cnicImage',
        filePath: cnicPath,
        mimeType: 'image/jpeg',
      ));
    }
    if (experiencePath != null) {
      files.add(MultipartFileItem(
        field: 'experienceImage',
        filePath: experiencePath,
        mimeType: 'image/jpeg',
      ));
    }
    if (policePath != null) {
      files.add(MultipartFileItem(
        field: 'policeImage',
        filePath: policePath,
        mimeType: 'image/jpeg',
      ));
    }

    return _client.multipartPost(
      ApiConstants.uploadDocuments,
      requireAuth: true,
      files: files.isNotEmpty ? files : null,
    );
  }
}

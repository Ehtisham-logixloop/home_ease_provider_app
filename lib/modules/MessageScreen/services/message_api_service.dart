import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/base_api_client.dart';
import '../../../data/models/ChatMessage.dart';
import '../../../data/models/MessageThread.dart';

class MessageApiService {
  static final MessageApiService _instance = MessageApiService._internal();
  factory MessageApiService() => _instance;
  MessageApiService._internal();

  final BaseApiClient _client = BaseApiClient();

  Future<List<MessageThread>> fetchMessageThreads() async {
    final response = await _client.get(
      ApiConstants.messageThreads,
      requireAuth: true,
    );

    if (response.success) {
      return response.parseList<MessageThread>(MessageThread.fromJson);
    }
    return <MessageThread>[];
  }

  Future<List<ChatMessage>> fetchChatMessages(String threadId) async {
    final response = await _client.get(
      '${ApiConstants.chatMessages}/$threadId',
      requireAuth: true,
    );

    if (response.success) {
      return response.parseList<ChatMessage>(ChatMessage.fromJson);
    }
    return <ChatMessage>[];
  }

  Future<ApiResponse> sendMessage({
    required String threadId,
    required String text,
  }) async {
    return _client.post(
      ApiConstants.sendMessage,
      requireAuth: true,
      body: {
        'threadId': threadId,
        'text': text,
        'message': text,
      },
    );
  }
}

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final String time;
  final String? messageId;
  final String? senderId;

  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.time,
    this.messageId,
    this.senderId,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    final String? currentUserId =
        json['_currentUserId']?.toString();
    final String senderId = json['senderId']?.toString() ??
        json['sender_id']?.toString() ??
        json['from']?.toString() ??
        '';
    final bool isSentByMe = currentUserId == null
        ? (json['isSentByMe']?.toString() == 'true' ||
            json['sentByMe']?.toString() == 'true' ||
            json['isMine']?.toString() == 'true')
        : senderId == currentUserId;

    return ChatMessage(
      text: json['text']?.toString() ??
          json['message']?.toString() ??
          json['content']?.toString() ??
          '',
      isSentByMe: isSentByMe,
      time: json['time']?.toString() ??
          json['timestamp']?.toString() ??
          json['createdAt']?.toString() ??
          '',
      messageId: json['messageId']?.toString() ??
          json['id']?.toString(),
      senderId: senderId,
    );
  }
}

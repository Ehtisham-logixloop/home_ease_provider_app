class MessageThread {
  final String name;
  final String role;
  final String lastMessage;
  final String time;
  final String image;
  final int unreadCount;
  final String? threadId;
  final String? userId;

  MessageThread({
    required this.name,
    required this.role,
    required this.lastMessage,
    required this.time,
    required this.image,
    this.unreadCount = 0,
    this.threadId,
    this.userId,
  });

  factory MessageThread.fromJson(Map<String, dynamic> json) {
    return MessageThread(
      name: json['name']?.toString() ??
          json['userName']?.toString() ??
          json['fullName']?.toString() ??
          '',
      role: json['role']?.toString() ??
          json['category']?.toString() ??
          '',
      lastMessage: json['lastMessage']?.toString() ??
          json['last_message']?.toString() ??
          json['message']?.toString() ??
          '',
      time: json['time']?.toString() ??
          json['timestamp']?.toString() ??
          json['createdAt']?.toString() ??
          '',
      image: json['image']?.toString() ??
          json['profileImage']?.toString() ??
          json['avatar']?.toString() ??
          'https://i.pravatar.cc/150',
      unreadCount: json['unreadCount'] is int
          ? json['unreadCount'] as int
          : int.tryParse(json['unreadCount']?.toString() ?? '0') ?? 0,
      threadId: json['threadId']?.toString() ??
          json['id']?.toString() ??
          json['conversationId']?.toString(),
      userId: json['userId']?.toString() ??
          json['senderId']?.toString() ??
          json['user_id']?.toString(),
    );
  }
}
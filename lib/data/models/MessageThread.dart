class MessageThread {
  final String name;
  final String role;
  final String lastMessage;
  final String time;
  final String image;
  final int unreadCount;

  MessageThread({
    required this.name,
    required this.role,
    required this.lastMessage,
    required this.time,
    required this.image,
    this.unreadCount = 0,
  });
}
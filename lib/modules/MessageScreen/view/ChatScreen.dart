import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/MessageThread.dart';
import '../../../data/models/ChatMessage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.thread});

  final MessageThread thread;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadInitialMessages();
  }

  void _loadInitialMessages() {
    _messages.addAll([
      ChatMessage(
        text: "Hey, are you available tomorrow?",
        isSentByMe: false,
        time: "14:30",
      ),
      ChatMessage(
        text: "Yes, I am! What do you need?",
        isSentByMe: true,
        time: "14:31",
      ),
      ChatMessage(
        text: "I need help with fixing my kitchen sink.",
        isSentByMe: false,
        time: "14:32",
      ),
    ]);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        final now = DateTime.now();
        _messages.add(ChatMessage(
          text: _messageController.text.trim(),
          isSentByMe: true,
          time: '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}',
        ));
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.thread.image),
              radius: Responsive.isMobile ? 20 : 24,
            ),
            SizedBox(width: Responsive.spaceS),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.thread.name,
                  style: TextStyle(
                    fontSize: Responsive.textM,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (widget.thread.role.isNotEmpty)
                  Text(
                    widget.thread.role,
                    style: TextStyle(
                      fontSize: Responsive.textS,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ],
        ),
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(Responsive.paddingM),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(bottom: Responsive.spaceM),
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.paddingM,
                      vertical: Responsive.paddingS,
                    ),
                    decoration: BoxDecoration(
                      color: message.isSentByMe
                          ? AppColors.primary
                          : AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(Responsive.cardRadius),
                      border: message.isSentByMe
                          ? null
                          : Border.all(color: AppColors.border),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: Responsive.width * 0.7,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          message.text,
                          style: TextStyle(
                            color: message.isSentByMe
                                ? AppColors.buttonText
                                : AppColors.textPrimary,
                            fontSize: Responsive.textM,
                          ),
                        ),
                        SizedBox(height: Responsive.spaceXS),
                        Text(
                          message.time,
                          style: TextStyle(
                            color: message.isSentByMe
                                ? AppColors.buttonText.withValues(alpha: 0.7)
                                : AppColors.textSecondary,
                            fontSize: Responsive.textXS,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.paddingM,
              vertical: Responsive.paddingS,
            ),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(color: AppColors.textSecondary),
                        filled: true,
                        fillColor: AppColors.scaffoldBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Responsive.buttonRadius * 2),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: Responsive.paddingL,
                          vertical: Responsive.paddingS,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.spaceS),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send, color: AppColors.buttonText),
                      onPressed: _sendMessage,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

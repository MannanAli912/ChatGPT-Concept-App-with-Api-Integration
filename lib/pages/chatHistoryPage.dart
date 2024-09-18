import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

// Chat History Page
class ChatHistoryPage extends StatelessWidget {
  final List<ChatMessage> chatHistory;

  ChatHistoryPage({required this.chatHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat History',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: chatHistory.length,
        itemBuilder: (context, index) {
          final message = chatHistory[index];
          return ListTile(
            title: Text('${message.user.firstName}: ${message.text}'),
            subtitle: Text('${message.createdAt}'),
          );
        },
      ),
    );
  }
}

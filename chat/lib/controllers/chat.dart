import 'package:chat/ui/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatController extends ChangeNotifier {
  final List<MessageBubble> messagesBubble = [];

  void addMessagesToBubbles(MessageBubble message) {
    messagesBubble.add(message);
    notifyListeners();
  }
}

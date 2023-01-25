import 'package:chat/data/uses_cases/messages.dart';
import 'package:chat/models/messages_response.dart';
import 'package:flutter/material.dart';

class ChatController extends ChangeNotifier {
  late MessagesListUseCase messagesListUseCase;

  ChatController({required this.messagesListUseCase});

  Future<List<Message>?> listAllMessages(String from) async {
    try {
      final MessagesListResponse messagesListResponse =
          await messagesListUseCase.call(
              params: MessagesUseCaseParams(from: from));
      return messagesListResponse.messages;
    } catch (e) {
      rethrow;
    }
  }
}

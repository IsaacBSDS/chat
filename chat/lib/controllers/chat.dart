import 'package:chat/data/uses_cases/messages.dart';
import 'package:chat/models/messages_response.dart';
import 'package:chat/utils/message_local_storage.dart';
import 'package:flutter/material.dart';

class ChatController extends ChangeNotifier {
  late MessagesListUseCase messagesListUseCase;

  ChatController({required this.messagesListUseCase});
  final MessageLocalStorage messageLocalStorage = MessageLocalStorage();

  List<dynamic>? messagesInLocal = [];

  Future<List<Message>?> listAllMessages(String from) async {
    try {
      final MessagesListResponse messagesListResponse =
          await messagesListUseCase.call(
              params: MessagesUseCaseParams(from: from));
      await messageLocalStorage.saveMessages(
        userUid: from,
        messages: messagesListResponse.toJson()["last_30"],
      );
      if (messagesInLocal != null &&
          messagesInLocal == messagesListResponse.toJson()["last_30"]) {
        return null;
      }
      return messagesListResponse.messages;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Message>?> listAllMessagesFromLocal(String from) async {
    final List<dynamic>? messagesInLocal =
        await messageLocalStorage.getMessages(userUid: from);
    this.messagesInLocal = messagesInLocal;
    notifyListeners();
    if (messagesInLocal != null) {
      return messagesInLocal
          .map(
            (e) => Message(
              from: e["from"],
              to: e["to"],
              message: e["message"],
              createdAt:
                  DateTime.parse(e["createdAt"] ?? DateTime.now().toString()),
              updatedAt:
                  DateTime.parse(e["updatedAt"] ?? DateTime.now().toString()),
            ),
          )
          .toList();
    }
    return null;
  }
}

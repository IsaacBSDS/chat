import 'dart:convert';

import 'package:chat/data/repository/messages.dart';
import 'package:chat/data/uses_cases/base.dart';
import 'package:chat/models/messages_response.dart';
import 'package:http/http.dart' as http;

class MessagesUseCaseParams {
  final String from;

  MessagesUseCaseParams({required this.from});
}

class MessagesListUseCase
    extends UseCase<MessagesListResponse, MessagesUseCaseParams> {
  MessagesListUseCase({required MessageRepository repository})
      : super(repository: repository);
  @override
  Future<MessagesListResponse> call(
      {required MessagesUseCaseParams params}) async {
    final http.Response response =
        await (repository as MessageRepository).getMessages(params.from);
    switch (response.statusCode) {
      case 200:
        return MessagesListResponse.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
      default:
        throw UseCaseException("Hubo un error.\nIntente de nuevo más tarde");
    }
  }
}

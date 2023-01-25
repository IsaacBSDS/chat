import 'dart:convert';

import 'package:chat/data/repository/user.dart';
import 'package:chat/data/uses_cases/base.dart';
import 'package:chat/models/users_list_response.dart';
import 'package:http/http.dart' as http;

class UserListUseCase extends UseCaseNoParams<UsersListResponse> {
  UserListUseCase({required UserRepository repository})
      : super(repository: repository);
  @override
  Future<UsersListResponse> call() async {
    final http.Response response =
        await (repository as UserRepository).listUsers();

    switch (response.statusCode) {
      case 200:
        return UsersListResponse.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
      default:
        throw UseCaseException("Hubo un error.\nIntente de nuevo más tarde.");
    }
  }
}

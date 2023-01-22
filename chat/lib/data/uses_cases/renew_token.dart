import 'dart:convert';

import 'package:chat/data/repository/user.dart';
import 'package:chat/data/uses_cases/base.dart';
import 'package:chat/models/login_response.dart';
import 'package:http/http.dart' as http;

class RenewTokenUseCaseParams {
  final String token;

  RenewTokenUseCaseParams({required this.token});
}

class RenewTokenUseCase
    extends UseCase<LoginResponse, RenewTokenUseCaseParams> {
  RenewTokenUseCase({required UserRepository repository})
      : super(repository: repository);

  @override
  Future<LoginResponse> call({required RenewTokenUseCaseParams params}) async {
    final http.Response response =
        await (repository as UserRepository).renewToken(params.token);
    switch (response.statusCode) {
      case 200:
        return LoginResponse.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
      default:
        throw UseCaseException("Hubo un error.\nIntente de nuevo más tarde.");
    }
  }
}

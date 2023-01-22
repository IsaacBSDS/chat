import 'dart:convert';

import 'package:chat/data/repository/user.dart';
import 'package:chat/data/uses_cases/base.dart';
import 'package:chat/models/login_response.dart';
import 'package:http/http.dart' as http;

class LoginUseCaseParams {
  final String username;
  final String password;

  LoginUseCaseParams({required this.username, required this.password});
}

class LoginUseCase extends UseCase<LoginResponse, LoginUseCaseParams> {
  LoginUseCase({required UserRepository repository})
      : super(repository: repository);

  @override
  Future<LoginResponse> call({required LoginUseCaseParams params}) async {
    final http.Response response = await (repository as UserRepository)
        .login(params.username, params.password);
    switch (response.statusCode) {
      case 200:
        return LoginResponse.fromJson(
            json.decode(utf8.decode(response.bodyBytes)));
      case 400:
        if (response.body.contains("password is wrong")) {
          throw UseCaseException("Contraseña incorrecta");
        }
        throw UseCaseException("Hubo un error.\nIntente de nuevo más tarde.");
      case 404:
        throw UseCaseException("Usuario no encontrado");
      default:
        throw UseCaseException("Hubo un error.\nIntente de nuevo más tarde.");
    }
  }
}

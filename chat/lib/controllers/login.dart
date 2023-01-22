import 'package:chat/data/uses_cases/login.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/utils/constanst.dart';
import 'package:chat/utils/local_storage.dart';
import 'package:chat/utils/session.dart';
import 'package:flutter/material.dart';

class LoginController extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginController({required this.loginUseCase});

  Future<bool> login() async {
    try {
      final LoginResponse loginResponse = await loginUseCase.call(
          params: LoginUseCaseParams(
        username: usernameController.text,
        password: passwordController.text,
      ));
      Session.instance.start(loginResponse);
      LocalStorage.save(Constants.token, loginResponse.toString());
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:chat/data/uses_cases/register.dart';
import 'package:flutter/material.dart';

class RegisterController extends ChangeNotifier {
  final RegisterUseCase registerUseCase;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  RegisterController({required this.registerUseCase});

  Future<bool> register() async {
    try {
      await registerUseCase.call(
        params: RegisterUseCaseParams(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text.trim(),
        ),
      );
      usernameController.clear();
      passwordController.clear();
      nameController.clear();
      return true;
    } catch (e) {
      rethrow;
    }
  }
}

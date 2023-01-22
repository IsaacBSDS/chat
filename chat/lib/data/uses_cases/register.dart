import 'package:chat/data/repository/user.dart';
import 'package:chat/data/uses_cases/base.dart';
import 'package:http/http.dart' as http;

class RegisterUseCaseParams {
  final String username;
  final String password;
  final String name;

  RegisterUseCaseParams(
      {required this.username, required this.password, required this.name});
}

class RegisterUseCase extends UseCase<void, RegisterUseCaseParams> {
  RegisterUseCase({required UserRepository repository})
      : super(repository: repository);

  @override
  Future<void> call({required RegisterUseCaseParams params}) async {
    final http.Response response = await (repository as UserRepository)
        .register(params.username, params.password, params.name);
    switch (response.statusCode) {
      case 200:
        break;
      case 400:
        if (response.body.contains("Username already exist")) {
          throw UseCaseException("Este usuario ya existe");
        }
        throw UseCaseException("Hubo un error.\nIntente de nuevo más tarde.");
      default:
        throw UseCaseException("Hubo un error.\nIntente de nuevo más tarde.");
    }
  }
}

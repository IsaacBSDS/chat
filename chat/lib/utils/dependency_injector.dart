import 'package:chat/controllers/login.dart';
import 'package:chat/data/repository/user.dart';
import 'package:chat/data/uses_cases/login.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class DependencyInjector {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      create: (_) => LoginController(
        loginUseCase: LoginUseCase(
          repository: UserRepository(),
        ),
      ),
    )
  ];
}

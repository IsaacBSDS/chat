import 'package:chat/controllers/chat.dart';
import 'package:chat/controllers/login.dart';
import 'package:chat/controllers/register.dart';
import 'package:chat/controllers/socket.dart';
import 'package:chat/controllers/splash.dart';
import 'package:chat/controllers/users.dart';
import 'package:chat/data/repository/messages.dart';
import 'package:chat/data/repository/user.dart';
import 'package:chat/data/uses_cases/login.dart';
import 'package:chat/data/uses_cases/messages.dart';
import 'package:chat/data/uses_cases/register.dart';
import 'package:chat/data/uses_cases/renew_token.dart';
import 'package:chat/data/uses_cases/users_list.dart';
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
    ),
    ChangeNotifierProvider(
      create: (_) => RegisterController(
        registerUseCase: RegisterUseCase(
          repository: UserRepository(),
        ),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => SplashController(
        renewTokenUseCase: RenewTokenUseCase(
          repository: UserRepository(),
        ),
      ),
    ),
    ChangeNotifierProvider(
      create: (_) => SocketService(),
    ),
    ChangeNotifierProvider(
      create: (_) => UsersController(
          userListUseCase: UserListUseCase(
        repository: UserRepository(),
      )),
    ),
    ChangeNotifierProvider(
      create: (_) => ChatController(
        messagesListUseCase: MessagesListUseCase(
          repository: MessageRepository(),
        ),
      ),
    ),
  ];
}

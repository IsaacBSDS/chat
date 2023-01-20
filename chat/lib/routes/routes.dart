import 'package:chat/routes/names.dart';
import 'package:chat/screens/chat.dart';
import 'package:chat/screens/loading.dart';
import 'package:chat/screens/login.dart';
import 'package:chat/screens/register.dart';
import 'package:chat/screens/users.dart';
import 'package:flutter/material.dart';

class CustomRoutes {
  static Route<dynamic> routes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesNames.chat:
        return MaterialPageRoute(
          builder: (context) => ChatScreen(),
          settings: settings,
        );
      case RoutesNames.loading:
        return MaterialPageRoute(
          builder: (context) => const LoadingScreen(),
          settings: settings,
        );
      case RoutesNames.login:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
          settings: settings,
        );
      case RoutesNames.register:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
          settings: settings,
        );
      case RoutesNames.users:
        return MaterialPageRoute(
          builder: (context) => UsersScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(),
          settings: settings,
        );
    }
  }
}

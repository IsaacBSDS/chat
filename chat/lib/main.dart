import 'dart:io';

import 'package:chat/ui/routes/routes.dart';
import 'package:chat/ui/screens/login.dart';
import 'package:chat/ui/theme/colors.dart';
import 'package:chat/utils/dependency_injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  if (Platform.isIOS || Platform.isAndroid) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }
  runApp(
    MultiProvider(
      providers: DependencyInjector.providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaleFactor:
                    MediaQuery.of(context).textScaleFactor.clamp(0.9, 1.4)),
            child: child!);
      },
      theme: ThemeData(iconTheme: IconThemeData(color: CustomColors.purple)),
      onGenerateRoute: CustomRoutes.routes,
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      home: const LoginScreen(),
    );
  }
}

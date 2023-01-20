import 'package:chat/routes/routes.dart';
import 'package:chat/screens/login.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: CustomRoutes.routes,
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      home: LoginScreen(),
    );
  }
}

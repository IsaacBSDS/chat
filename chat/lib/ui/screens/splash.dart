// ignore_for_file: use_build_context_synchronously

import 'package:chat/controllers/splash.dart';
import 'package:chat/ui/routes/names.dart';
import 'package:chat/ui/theme/colors.dart';
import 'package:chat/ui/widgets/custom_text.dart';
import 'package:chat/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> _checkIsAuthenticated(BuildContext context) async {
    final SplashController splashController = context.read();

    try {
      final bool response = await splashController.renewToken();
      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    _checkIsAuthenticated(context).then((value) {
      if (value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(RoutesNames.users, (route) => false);
      } else {
        Future.delayed(
          const Duration(seconds: 2),
          () => Navigator.of(context)
              .pushNamedAndRemoveUntil(RoutesNames.login, (route) => false),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive r = Responsive.of(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
                child: Image.asset(
              "assets/chat.png",
              color: CustomColors.purple,
              width: r.wp(30),
              height: r.wp(30),
            )),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: r.hp(2),
            height: r.hp(2),
            child: CircularProgressIndicator(
              color: CustomColors.purple,
            ),
          ),
          CustomText(
            text: "Chat.",
            fontSize: r.dp(4),
            fontWeight: FontWeight.w800,
          ),
          SizedBox(
            height: r.hp(4),
          )
        ],
      ),
    );
  }
}

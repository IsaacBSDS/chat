import 'dart:convert';
import 'dart:developer';

import 'package:chat/data/uses_cases/renew_token.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/utils/constanst.dart';
import 'package:chat/utils/local_storage.dart';
import 'package:chat/utils/session.dart';
import 'package:flutter/material.dart';

class SplashController extends ChangeNotifier {
  final RenewTokenUseCase renewTokenUseCase;

  SplashController({required this.renewTokenUseCase});

  Future<bool> renewToken() async {
    try {
      final String? noParsedToken = await LocalStorage.read(Constants.token);
      if (noParsedToken != null) {
        final LoginResponse localToken =
            LoginResponse.fromJson(json.decode(noParsedToken));
        Session.instance.start(localToken);
        final LoginResponse renewResponse = await renewTokenUseCase.call();
        Session.instance.start(renewResponse);
        return true;
      }
      return false;
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      LocalStorage.delete(Constants.token);
      rethrow;
    }
  }
}

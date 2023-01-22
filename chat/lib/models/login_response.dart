import 'dart:convert';

import 'package:chat/models/users.dart';

class LoginResponse {
  LoginResponse({
    this.ok,
    this.user,
    this.token,
  });

  final bool? ok;
  final UserModel? user;
  final String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        user: UserModel.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "user": user?.toJson(),
        "token": token,
      };

  @override
  String toString() {
    return json.encode(toJson());
  }
}

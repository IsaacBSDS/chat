import 'package:chat/models/login_response.dart';

class Session {
  Session._();
  static final Session _instance = Session._();
  static Session get instance => _instance;

  LoginResponse loginResponse = LoginResponse();

  start(LoginResponse loginResponse) {
    this.loginResponse = loginResponse;
  }
}

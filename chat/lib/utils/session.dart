import 'package:chat/models/login_response.dart';
import 'package:chat/utils/constanst.dart';
import 'package:chat/utils/local_storage.dart';

class Session {
  Session._();
  static final Session _instance = Session._();
  static Session get instance => _instance;

  LoginResponse loginResponse = LoginResponse();

  start(LoginResponse loginResponse) {
    this.loginResponse = loginResponse;
  }

  stop() {
    loginResponse = LoginResponse();
    LocalStorage.delete(Constants.token);
    LocalStorage.delete(Constants.messages);
  }
}

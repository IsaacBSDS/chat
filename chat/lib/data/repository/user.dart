import 'package:chat/data/repository/base.dart';
import 'package:http/http.dart' as http;

class UserRepository extends Repository {
  Future<http.Response> login(String username, String password) async {
    final http.Response response =
        await post("/login", {"username": username, "password": password});

    return response;
  }
}

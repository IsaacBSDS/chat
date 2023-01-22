import 'package:chat/data/repository/base.dart';
import 'package:http/http.dart' as http;

class UserRepository extends Repository {
  Future<http.Response> login(String username, String password) async {
    final http.Response response =
        await post("/login", {"username": username, "password": password});
    return response;
  }

  Future<http.Response> register(
      String username, String password, String name) async {
    final http.Response response = await post("/login/new",
        {"username": username, "password": password, "name": name});
    return response;
  }

  Future<http.Response> renewToken(String token) async {
    final http.Response response = await get("/login/renew");
    return response;
  }
}

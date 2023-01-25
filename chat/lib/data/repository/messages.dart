import 'package:chat/data/repository/base.dart';
import 'package:http/http.dart' as http;

class MessageRepository extends Repository {
  Future<http.Response> getMessages(String from) {
    return get("/messages/$from");
  }
}

import 'dart:convert';

import 'package:chat/utils/session.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class Api {
  final String apiUrl = dotenv.get("apiUrl");
  final Session session = Session.instance;

  Map<String, String> get headers => _buildHeaders();
  Map<String, String> get headersWithoutAuth => _buildHeadersWithoutAuth();

  Map<String, String> _buildHeadersWithoutAuth() {
    final Map<String, String> headers = {"x-api-key": dotenv.get("x-api-key")};

    return headers;
  }

  Map<String, String> _buildHeaders() {
    // if (session.userToken != null) {
    //   headers.addAll({"Authorization": "Bearer ${session.userToken!.access}"});
    // }
    return headers;
  }

  Future<http.Response> get(String path, {bool? useAuth = true}) {
    return http
        .get(Uri.parse("$apiUrl$path"),
            headers: useAuth! ? headers : headersWithoutAuth)
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        return http.Response('', 408);
      },
    );
  }

  Future<http.Response> post(String path, Map<String, dynamic> body,
      {bool? useAuth = true}) {
    return http.post(Uri.parse("$apiUrl$path"),
        body: jsonEncode(body), headers: {"Content-type": "application/json"});
  }

  Future<http.Response> put(String path, Map<String, dynamic> body,
      {bool? useAuth = true}) {
    return http.put(Uri.parse("$apiUrl$path"),
        body: body, headers: useAuth! ? headers : headersWithoutAuth);
  }
}

class Repository extends Api {}

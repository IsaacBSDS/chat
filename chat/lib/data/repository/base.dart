import 'dart:convert';

import 'package:chat/utils/session.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

abstract class Api {
  final String apiUrl = dotenv.get("apiUrl");
  final Session session = Session.instance;

  Map<String, String> get headers => _buildHeaders();

  Map<String, String> _buildHeaders() {
    final Map<String, String> headers = {"Content-type": "application/json"};

    if (session.loginResponse.token != null) {
      headers.addAll(
        {"Authorization": "Bearer ${session.loginResponse.token}"},
      );
    } else {
      if (headers.containsKey("Authorization")) {
        headers.remove("Authorization");
      }
    }
    return headers;
  }

  Future<http.Response> get(String path, {bool? useAuth = true}) {
    return http.get(Uri.parse("$apiUrl$path"), headers: headers).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        return http.Response('', 408);
      },
    );
  }

  Future<http.Response> post(String path, Map<String, dynamic> body) {
    return http.post(
      Uri.parse("$apiUrl$path"),
      body: jsonEncode(body),
      headers: headers,
    );
  }

  Future<http.Response> put(String path, Map<String, dynamic> body,
      {bool? useAuth = true}) {
    return http.put(Uri.parse("$apiUrl$path"));
  }
}

class Repository extends Api {}

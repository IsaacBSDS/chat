import 'dart:developer';

import 'package:chat/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum ServerStatus { online, offline, connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.connecting;
  late Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  Socket? get socket => _socket;
  Function get emit => _socket.emit;

  void connect() async {
    log("connecting", name: "Socket");

    final String? token = Session.instance.loginResponse.token;
    _socket = io(
      dotenv.get("socketUrl"),
      OptionBuilder()
          .setTransports(["websocket"])
          .enableForceNew()
          .disableAutoConnect()
          .setExtraHeaders({"Authorization": "Bearer $token"})
          .build(),
    );

    if (serverStatus != ServerStatus.online) {
      _socket.connect();
    }
    _socket.onConnect((data) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
      log("Connected", name: "Socket");
    });

    _socket.on("user_connect", (data) => log(data.toString()));
  }

  void disconnect() {
    _serverStatus = ServerStatus.offline;
    notifyListeners();
    log("Disconnected", name: "Socket");
    _socket.disconnect();
  }
}

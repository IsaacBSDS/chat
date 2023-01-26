import 'dart:convert';

import 'package:chat/utils/constanst.dart';
import 'package:chat/utils/local_storage.dart';

class MessageLocalStorage {
  /// NOTA PARA EL FUTURO:

  /// ESTE SISTEMA LO QUE HACE ES GUARDAR TODOS LOS MENSAJES EN EL LOCALSTORAGE DEL CELULAR
  /// LUEGO LOS OBTIENE Y PINTA PRIMERO LOS MENSAJES QUE ESTáN GUARDADOS.
  /// UNA VEZ REALIZADO LO ANTERIOR CONSULTA A LA BASE DE DATOS PARA TRAER TODOS LOS MENSAJES.
  /// SI LOS MENSAJES QUE VIENEN DE LA BASE DE DATOS NO SON IGUALES A LOS MENSAJES GUARDADOS EN EL DISPOSITIVO,
  /// SE DIBUJAN ESTOS NUEVOS MENSAJES Y SE GUARDAN NUEVAMENTE EN EL LOCALSTORAGE DEL DISPOSITIVO.

  /// ACTUALMENTE ES LA PRIMERA VERSIóN. SI AQUELLOS QUE CLONEN ESTE CóDIGO (O ISAAC DEL FUTURO) ENCUENTRAN UNA MEJOR SOLUCIóN
  /// BIENVENIDA SEA.

  Future<List<dynamic>?> getMessages({required String userUid}) async {
    final String? allMessages = await LocalStorage.read(Constants.messages);
    if (allMessages == null) {
      return null;
    }
    final Map<String, dynamic> decodedMessages = json.decode(allMessages);
    if (!decodedMessages.containsKey(userUid)) {
      return null;
    }
    return decodedMessages[userUid];
  }

  Future<void> saveMessages({
    required String userUid,
    required List<dynamic> messages,
  }) async {
    final String? allMessages = await LocalStorage.read(Constants.messages);

    final Map<String, dynamic> decodedMessages =
        json.decode(allMessages ?? "{}");
    if (!decodedMessages.containsKey(userUid)) {
      await _saveMessages(userUid, messages, decodedMessages);
      return;
    }
    if (decodedMessages.containsKey(userUid) &&
        decodedMessages[userUid] != messages) {
      await _saveMessages(userUid, messages, decodedMessages);
      return;
    }
    return;
  }

  Future<void> _saveMessages(String userUid, dynamic messages,
      Map<String, dynamic> decodedMessages) async {
    decodedMessages.addAll({userUid: messages});
    await LocalStorage.delete(Constants.messages);
    await LocalStorage.save(Constants.messages, json.encode(decodedMessages));
  }

  Future<void> saveIndividualMessage(
      {required String userUid, required dynamic message}) async {
    final String? allMessages = await LocalStorage.read(Constants.messages);

    final Map<String, dynamic> decodedMessages =
        json.decode(allMessages ?? "{}");

    if (!decodedMessages.containsKey(userUid)) {
      final toAdd = {
        userUid: [message]
      };
      decodedMessages.addAll(toAdd);
      _saveIndividualMessage(decodedMessages);
    } else {
      final List<dynamic> messagesOfUser = decodedMessages[userUid];
      messagesOfUser.add(message);
      decodedMessages[userUid] = messagesOfUser;
      _saveIndividualMessage(decodedMessages);
    }
  }

  Future<void> _saveIndividualMessage(
      Map<String, dynamic> decodedMessages) async {
    await LocalStorage.delete(Constants.messages);
    await LocalStorage.save(Constants.messages, json.encode(decodedMessages));
  }
}

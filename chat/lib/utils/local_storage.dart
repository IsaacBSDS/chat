import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static const storage = FlutterSecureStorage();

  static Future<void> save(String key, String data) async {
    await storage.write(key: key, value: data);
  }

  static Future<String?> read(String key) async {
    String? value = await storage.read(key: key);
    return value;
  }

  static Future<void> delete(String key) async {
    await storage.delete(key: key);
  }
}

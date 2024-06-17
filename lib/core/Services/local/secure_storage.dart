import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> setSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> getSecureData(String key) async {
    String? value = await storage.read(key: key);
    print('Data read from secure storage: $value');
    return value;
  }

  Future<void> deleteSecureData(String key) async {
    await storage.delete(key: key);
  }
}

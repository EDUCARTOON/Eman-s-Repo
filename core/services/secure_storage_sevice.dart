import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageServices {
  SecureStorageServices._internal();
  static final SecureStorageServices _instance =
      SecureStorageServices._internal();
  factory SecureStorageServices() => _instance;

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> saveData({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw Exception("Error saving data to secure storage: $e");
    }
  }

  /// Retrieve data from secure storage
  Future<String?> getData({required String key}) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      log(e.toString());
      throw Exception("Error retrieving data from secure storage: $e");
    }
  }

  /// Delete specific data from secure storage
  Future<void> deleteData({required String key}) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      throw Exception("Error deleting data from secure storage: $e");
    }
  }

  /// Clear all data from secure storage
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      throw Exception("Error clearing secure storage: $e");
    }
  }
}

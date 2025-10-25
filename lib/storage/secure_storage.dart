import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  /// Save a value (String, int, bool, Map, List)
  static Future<void> saveData(String key, dynamic value) async {
    String encodedValue;

    if (value is String) {
      encodedValue = value;
    } else if (value is num || value is bool) {
      encodedValue = value.toString();
    } else {
      // For Map, List, or custom objects
      encodedValue = jsonEncode(value);
    }

    await _storage.write(key: key, value: encodedValue);
  }

  /// Retrieve a value as String
  static Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  /// Retrieve a value as int
  static Future<int?> getInt(String key) async {
    final value = await _storage.read(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  /// Retrieve a value as bool
  static Future<bool?> getBool(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;
    return value.toLowerCase() == 'true';
  }

  /// Retrieve a value as Map (for JSON)
  static Future<Map<String, dynamic>?> getMap(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;
    try {
      return jsonDecode(value) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Retrieve a List (for JSON arrays)
  static Future<List<dynamic>?> getList(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) return null;
    try {
      return jsonDecode(value) as List<dynamic>;
    } catch (_) {
      return null;
    }
  }

  /// Delete a specific key
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Clear all data
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// Check if a key exists
  static Future<bool> containsKey(String key) async {
    final all = await _storage.readAll();
    return all.containsKey(key);
  }
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:njm_mobileapp/constants/key_constants.dart';
import 'package:njm_mobileapp/constants/string_constants.dart';
import 'package:njm_mobileapp/models/user_model.dart';

class UserStorage {
  static const _boxName = BoxTitleStrConstants.userBox;
  static late Box _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    _box = await Hive.openBox(_boxName);
  }

  /// Save user details
  static Future<void> saveUser(UserModel user) async {
    await _box.put(KeyConstants.user, user);
    await _box.put(KeyConstants.isLogged, true);
  }

  static UserModel? getUser() {
    return _box.get(KeyConstants.user);
  }

  static bool isLoggedIn() {
    return _box.get(KeyConstants.isLogged, defaultValue: false);
  }

  static Future<void> clearUser() async {
    await _box.clear();
  }
}

import 'package:hive/hive.dart';
import 'package:njm_mobileapp/constants/key_constants.dart';

part 'user_model.g.dart'; // generated adapter

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String user_id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String email;

  @HiveField(3)
  String phoneNumber;

  UserModel({
    required this.user_id,
    required this.username,
    required this.email,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user_id: json[KeyConstants.user_id] ?? '',
      username: json[KeyConstants.username] ?? '',
      email: json[KeyConstants.email] ?? '',
      phoneNumber: json[KeyConstants.phoneNumber] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    KeyConstants.user_id: user_id,
    KeyConstants.username: username,
    KeyConstants.email: email,
    KeyConstants.phoneNumber: phoneNumber,
  };
}

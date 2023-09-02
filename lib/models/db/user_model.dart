import 'dart:convert';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 3)
class UserModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String email;

  @HiveField(2)
  String accessToken;

  @HiveField(3)
  String refreshToken;

  UserModel({
    this.id,
    required this.email,
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'email': email,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };

  //TODO: fix mapping

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map['user_id'] == null && map['userId'] == null) {
      return UserModel(
        id: map['id'] as int,
        email: map['login'] as String,
        accessToken: map['accessToken'] as String,
        refreshToken: map['refreshToken'] as String,
      );
    }

    if (map['user_id'] == null) {
      return UserModel(
        id: map['userId'] as int,
        email: map['email'] as String,
        accessToken: map['accessToken'] as String,
        refreshToken: map['refreshToken'] as String,
      );
    } else {
      return UserModel(
        id: map['user_id'] as int,
        email: map['email'] as String,
        accessToken: map['accessToken'] as String,
        refreshToken: map['refreshToken'] as String,
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    int? id,
    String? email,
    bool? firstSignIn,
    String? accessToken,
    String? refreshToken,
    String? name,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );
}

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int? id;
  String login;
  bool firstSignIn;
  String accessToken;
  String refreshToken;
  String? name;
  UserModel(
      {this.id,
      required this.login,
      required this.firstSignIn,
      required this.accessToken,
      required this.refreshToken,
      this.name});

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'login': login,
        'firstSignIn': firstSignIn,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'name': name
      };

  //TODO: fix mapping

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map['user_id'] == null) {
      return UserModel(
        id: map['id'] as int,
        login: map['login'] as String,
        firstSignIn: map['firstSignin'] as int == 1,
        accessToken: map['accessToken'] as String,
        refreshToken: map['refreshToken'] as String,
        name: map['name'] as String,
      );
    } else {
      return UserModel(
        id: map['user_id'] as int,
        login: map['login'] as String,
        firstSignIn: map['firstSignin'] as int == 1,
        accessToken: map['accessToken'] as String,
        refreshToken: map['refreshToken'] as String,
        name: map['name'] as String,
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith(
          {int? id,
          String? login,
          bool? firstSignIn,
          String? accessToken,
          String? refreshToken,
          String? name}) =>
      UserModel(
          id: id ?? this.id,
          login: login ?? this.login,
          firstSignIn: firstSignIn ?? this.firstSignIn,
          accessToken: accessToken ?? this.accessToken,
          refreshToken: refreshToken ?? this.refreshToken,
          name: name ?? this.name);
}

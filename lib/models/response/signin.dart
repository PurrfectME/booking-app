// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignInResponse {
  bool firstSignin;
  String accessToken;
  String refreshToken;
  SignInResponse({
    required this.firstSignin,
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstSignin': firstSignin,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory SignInResponse.fromMap(Map<String, dynamic> map) {
    return SignInResponse(
      firstSignin: map['first_signin'] as bool,
      accessToken: map['access_token'] as String,
      refreshToken: map['refresh_token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInResponse.fromJson(String source) =>
      SignInResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

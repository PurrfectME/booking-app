import 'dart:convert';

class SignInRequest {
  String login;
  SignInRequest({
    required this.login,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'login': login,
    };
  }

  factory SignInRequest.fromMap(Map<String, dynamic> map) {
    return SignInRequest(
      login: map['login'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignInRequest.fromJson(String source) =>
      SignInRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}

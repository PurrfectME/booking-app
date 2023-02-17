import 'dart:convert';

class UserRequest {
  String name;
  UserRequest({
    required this.name,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
      };

  factory UserRequest.fromMap(Map<String, dynamic> map) => UserRequest(
        name: map['name'] as String,
      );

  String toJson() => json.encode(toMap());

  factory UserRequest.fromJson(String source) =>
      UserRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

class GetReservationResponse {
  int id;
  DateTime from;
  DateTime to;

  GetReservationResponse(
    this.id,
    this.from,
    this.to,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'from': from,
      'to': to,
    };
  }

  factory GetReservationResponse.fromMap(Map<String, dynamic> map) {
    return GetReservationResponse(
      map['id'] as int,
      map['from'] as DateTime,
      map['to'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetReservationResponse.fromJson(String source) =>
      GetReservationResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

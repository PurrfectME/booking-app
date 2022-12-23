import 'dart:convert';

class GetUserReservationResponse {
  int placeId;
  int tableId;
  DateTime from;
  DateTime to;
  int guests;
  GetUserReservationResponse({
    required this.placeId,
    required this.tableId,
    required this.from,
    required this.to,
    required this.guests,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'placeId': placeId,
      'tableId': tableId,
      'from': from.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
      'guests': guests,
    };
  }

  factory GetUserReservationResponse.fromMap(Map<String, dynamic> map) {
    return GetUserReservationResponse(
      placeId: map['placeId'] as int,
      tableId: map['tableId'] as int,
      from: DateTime.fromMillisecondsSinceEpoch(map['from'] as int),
      to: DateTime.fromMillisecondsSinceEpoch(map['to'] as int),
      guests: map['guests'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetUserReservationResponse.fromJson(String source) =>
      GetUserReservationResponse.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

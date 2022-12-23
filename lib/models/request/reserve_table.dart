import 'dart:convert';

class ReserveTableRequest {
  int placeId;
  int tableId;
  DateTime from;
  DateTime to;

  ReserveTableRequest({
    required this.placeId,
    required this.tableId,
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'placeId': placeId,
      'tableId': tableId,
      'from': from,
      'to': to,
    };
  }

  factory ReserveTableRequest.fromMap(Map<String, dynamic> map) {
    return ReserveTableRequest(
      placeId: map['placeId'] as int,
      tableId: map['tableId'] as int,
      from: map['from'] as DateTime,
      to: map['to'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReserveTableRequest.fromJson(String source) =>
      ReserveTableRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

class ReservationModel {
  int id;
  int tableId;
  int from;
  int to;
  ReservationModel(this.id, this.tableId, this.from, this.to);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tableId': tableId,
      'from': from,
      'to': to,
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      map['id'] as int,
      map['tableId'] as int,
      map['from'] as int,
      map['to'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservationModel.fromJson(String source) =>
      ReservationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';

class ReservationModel {
  int? id;
  int tableId;
  int start;
  int end;
  ReservationModel(this.id, this.tableId, this.start, this.end);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'tableId': tableId,
      'start': start,
      'end': end,
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      map['id'] as int,
      map['tableId'] as int,
      map['start'] as int,
      map['end'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservationModel.fromJson(String source) =>
      ReservationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

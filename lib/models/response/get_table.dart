import 'dart:convert';

class GetAvailableTable {
  int id;
  DateTime from;
  DateTime to;

  GetAvailableTable(
    this.id,
    this.from,
    this.to,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'from': from.millisecondsSinceEpoch,
      'to': to.millisecondsSinceEpoch,
    };
  }

  factory GetAvailableTable.fromMap(Map<String, dynamic> map) {
    return GetAvailableTable(
      map['id'] as int,
      DateTime.fromMillisecondsSinceEpoch(map['from'] as int),
      DateTime.fromMillisecondsSinceEpoch(map['to'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory GetAvailableTable.fromJson(String source) =>
      GetAvailableTable.fromMap(json.decode(source) as Map<String, dynamic>);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TableModel extends Equatable {
  final int id;
  final bool isFree;
  final int guestsCount;

  const TableModel(
      {required this.id, required this.isFree, required this.guestsCount});

  @override
  List<Object?> get props => [id, isFree, guestsCount];

  TableModel copyWith({
    int? id,
    bool? isFree,
    int? guestsCount,
  }) {
    return TableModel(
      id: id ?? this.id,
      isFree: isFree ?? this.isFree,
      guestsCount: guestsCount ?? this.guestsCount,
    );
  }
}

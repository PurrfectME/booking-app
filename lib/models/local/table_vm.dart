import 'package:booking_app/models/models.dart';

class TableViewModel {
  TableModel table;
  int? from;
  int? to;
  bool isReservedByUser;
  TableViewModel(this.table, this.from, this.to, this.isReservedByUser);
}

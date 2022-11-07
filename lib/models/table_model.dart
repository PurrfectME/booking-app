class TableModel {
  bool isFree;
  int guestsCount;
  TableConfig? config;

  TableModel(
      {required this.isFree, required this.guestsCount, required this.config});
}

class TableConfig {
  double? left;
  double? right;
  double? bottom;
  double? top;

  TableConfig({this.left, this.right, this.bottom, this.top});
}

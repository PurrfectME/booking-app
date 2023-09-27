import 'package:booking_app/models/db/measure.dart';

// ignore: avoid_classes_with_only_static_members
class MeasureHelper {
  static String fromMeasure(Measure measure) {
    switch (measure) {
      case Measure.killograms:
        return 'килограммы';
      case Measure.bottles:
        return 'бутылки';
      case Measure.boxes:
        return 'коробки';
      case Measure.litres:
        return 'литры';
      case Measure.packs:
        return 'пачки';
      case Measure.pieces:
        return 'штуки';
      default:
        return 'не установлено';
    }
  }
}

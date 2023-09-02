import 'package:booking_app/models/models.dart';
import 'package:hive/hive.dart';

part 'place_model.g.dart';

@HiveType(typeId: 1)
class PlaceModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  int logoId;

  @HiveField(4)
  String? base64Logo;

  @HiveField(5)
  int updateDate;

  @HiveField(6)
  List<TableModel> tables;

  @HiveField(7)
  int ownerId;

  @HiveField(8)
  String city;

  @HiveField(9)
  String address;

  @HiveField(10)
  bool allowBooking;

  PlaceModel(
      this.id,
      this.name,
      this.description,
      this.logoId,
      this.base64Logo,
      this.updateDate,
      this.tables,
      this.ownerId,
      this.city,
      this.address,
      this.allowBooking);

  PlaceModel copyWith({
    int? id,
    String? name,
    String? description,
    int? logoId,
    String? base64Logo,
    int? updateDate,
    List<TableModel>? tables,
    int? ownerId,
    String? city,
    String? address,
    bool? allowBooking,
  }) =>
      PlaceModel(
        id ?? this.id,
        name ?? this.name,
        description ?? this.description,
        logoId ?? this.logoId,
        base64Logo ?? this.base64Logo,
        updateDate ?? this.updateDate,
        tables ?? this.tables,
        ownerId ?? this.ownerId,
        city ?? this.city,
        address ?? this.address,
        allowBooking ?? this.allowBooking,
      );
}

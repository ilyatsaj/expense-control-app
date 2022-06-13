import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  double? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  int totalAmount;

  @HiveField(4)
  int? iconData;

  @HiveField(5)
  DateTime dc;

  Category(
      {this.id,
      required this.name,
      required this.description,
      required this.totalAmount,
      required this.dc,
      this.iconData});
}

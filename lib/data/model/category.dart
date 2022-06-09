import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  @HiveField(2)
  int totalAmount;

  @HiveField(3)
  int iconData;

  Category(
      {required this.name,
      required this.description,
      required this.totalAmount,
      required this.iconData});
}

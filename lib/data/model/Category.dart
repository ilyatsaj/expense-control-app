import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Category {
  Category(
      {required this.name,
      required this.totalAmount,
      this.description = 'some category description'});

  @HiveField(0)
  String name;

  @HiveField(1)
  String description;

  int totalAmount;

  void set(String name) {
    this.name = name;
  }
}

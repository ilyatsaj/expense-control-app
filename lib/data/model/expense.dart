import 'package:hive/hive.dart';
part 'expense.g.dart';

@HiveType(typeId: 2)
class Expense extends HiveObject {
  @HiveField(0)
  double? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  int amount;

  @HiveField(4)
  int? iconData;

  @HiveField(5)
  double categoryId;

  @HiveField(6)
  DateTime dc;

  Expense(
      {this.id,
      required this.categoryId,
      required this.name,
      required this.description,
      required this.amount,
      required this.dc,
      this.iconData});
}

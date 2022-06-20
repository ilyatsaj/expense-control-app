import 'package:hive/hive.dart';
part 'filter_date_time.g.dart';

@HiveType(typeId: 3)
class FilterDateTime extends HiveObject {
  @HiveField(0)
  double? id;

  @HiveField(1)
  DateTime? startDate;

  @HiveField(2)
  DateTime? endTime;

  FilterDateTime({
    this.id,
    required this.startDate,
    required this.endTime,
  });
}

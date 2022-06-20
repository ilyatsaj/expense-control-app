import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/filter_date_time.dart';

class FilterDateTimeData {
  //

  late Box<FilterDateTime> _filterDateTimeHive;

  Future<void> init() async {
    _filterDateTimeHive = await Hive.openBox<FilterDateTime>('filterDateTime');

    // await _filterDateTimeHive.clear();
    //
    // final filter =
    //     FilterDateTime(startDate: DateTime.now(), endTime: DateTime.now());
    // await _filterDateTimeHive.add(filter);
  }

  Future<DateTimeRange> getFilterDateTimeRange() async {
    _filterDateTimeHive = await Hive.openBox<FilterDateTime>('filterDateTime');
    await Future.delayed(Duration(seconds: 1));
    final filterStart =
        _filterDateTimeHive.values.first.startDate ?? DateTime.now();
    final filterEnd =
        _filterDateTimeHive.values.first.endTime ?? DateTime.now();
    final dtr = DateTimeRange(start: filterStart, end: filterEnd);
    return dtr;
  }

  Future<void> setFilterDateTime(DateTimeRange dateTimeRange) async {
    _filterDateTimeHive = await Hive.openBox<FilterDateTime>('filterDateTime');
    await Future.delayed(Duration(seconds: 1));
    final filterToUpdate = _filterDateTimeHive.values.first;
    filterToUpdate.startDate = dateTimeRange.start;
    filterToUpdate.endTime = dateTimeRange.end;
    await filterToUpdate.save();
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/filter_date_time.dart';

class FilterDateTimeData {
  //

  late Box<FilterDateTime> _filterDateTimeHive;

  Future<void> init() async {
    _filterDateTimeHive =
        await Hive.openBox<FilterDateTime>('filter_date_time');
  }

  Future<DateTimeRange> getFilterDateTimeRange() async {
    _filterDateTimeHive =
        await Hive.openBox<FilterDateTime>('filter_date_time');
    final DateTime filterStart;
    final DateTime filterEnd;
    if (_filterDateTimeHive.values.isNotEmpty) {
      filterStart = _filterDateTimeHive.values.first.startDate!;
      filterEnd = _filterDateTimeHive.values.first.endTime!;
    } else {
      filterStart = DateTime.now();
      filterEnd = DateTime.now();
    }
    final dtr = DateTimeRange(start: filterStart, end: filterEnd);
    return dtr;
  }

  Future<void> setFilterDateTime(DateTimeRange dateTimeRange) async {
    _filterDateTimeHive =
        await Hive.openBox<FilterDateTime>('filter_date_time');
    //await Future.delayed(Duration(seconds: 1));
    final FilterDateTime filterToUpdate;
    if (_filterDateTimeHive.isNotEmpty) {
      filterToUpdate = _filterDateTimeHive.values.first;
      filterToUpdate.startDate = dateTimeRange.start;
      filterToUpdate.endTime = dateTimeRange.end;
      await filterToUpdate.save();
    } else {
      filterToUpdate = FilterDateTime(
          startDate: dateTimeRange.start, endTime: dateTimeRange.end);
      _filterDateTimeHive.add(filterToUpdate);
    }
  }
}

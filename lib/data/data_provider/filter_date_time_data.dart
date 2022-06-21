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
    print('here we go again');
    _filterDateTimeHive =
        await Hive.openBox<FilterDateTime>('filter_date_time');
    print('here we initiated');
    //print(_filterDateTimeHive.values.length);
    final DateTime filterStart;
    final DateTime filterEnd;
    //await Future.delayed(Duration(seconds: 1));
    print(_filterDateTimeHive.values.isNotEmpty);
    if (_filterDateTimeHive.values.isNotEmpty) {
      //print('QQQQQ' + _filterDateTimeHive.values.length.toString());
      filterStart = _filterDateTimeHive.values.first.startDate!;
      print('here we filtStart');
      filterEnd = _filterDateTimeHive.values.first.endTime!;
    } else {
      filterStart = DateTime.now();
      filterEnd = DateTime.now();
    }
    print('here we filtEnd');
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

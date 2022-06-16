import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateHelper {
  static Future<DateTimeRange?> getFilterRange() async {
    final prefs = await SharedPreferences.getInstance();

    final String? filter_start = prefs.getString('filter_start');
    final String? filter_end = prefs.getString('filter_end');
    DateTimeRange? dtRange;
    if (filter_start != null && filter_end != null) {
      dtRange = DateTimeRange(
          start: DateTime.parse(filter_start), end: DateTime.parse(filter_end));
    }
    return dtRange;
  }

  static String selectedDateRangeString(DateTimeRange? selectedDateRange) {
    print('nen');
    print(selectedDateRange?.start.toString());
    //DateTimeRange? dtr = await getFilterRange();
    if (selectedDateRange != null) {
      return "${DateFormat.yMMMMd().format(selectedDateRange.start)} - ${DateFormat.yMMMMd().format(selectedDateRange.end)}";
    } else {
      return "${DateFormat.yMMMMd().format(DateTime.now())} - ${DateFormat.yMMMMd().format(DateTime.now())}";
    }
  }

  static DateTimeRange selectedDateRangeDT(DateTimeRange? selectedDateRange) {
    if (selectedDateRange != null) {
      return selectedDateRange;
    } else {
      return DateTimeRange(
          start: DateTime.now(),
          end: DateTime
              .now()); // DateFormat.yMMMMd().format(DateTime(2022, 06, 06))} - ${DateFormat.yMMMMd().format(DateTime.now())}";
    }
  }
}

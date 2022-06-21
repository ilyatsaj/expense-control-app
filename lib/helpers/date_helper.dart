import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static String dateRangeToFormattedString(DateTimeRange? selectedDateRange) {
    if (selectedDateRange != null) {
      return "${DateFormat.yMMMMd().format(selectedDateRange.start)} - ${DateFormat.yMMMMd().format(selectedDateRange.end)}";
    } else {
      return "${DateFormat.yMMMMd().format(DateTime.now())} - ${DateFormat.yMMMMd().format(DateTime.now())}";
    }
  }
}

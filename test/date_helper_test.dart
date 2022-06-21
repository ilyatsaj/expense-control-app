import 'package:expense_control_app/helpers/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("dateRangeToFormattedString method returns formatted string", () {
    String result = DateHelper.dateRangeToFormattedString(
        DateTimeRange(start: DateTime(2022, 1, 1), end: DateTime(2022, 2, 2)));
    String expectation = 'January 1, 2022 - February 2, 2022';
    expect(result, expectation);
  });
}

import 'package:expense_control_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('widget exists', (WidgetTester tester) async {
    await tester.pumpWidget(ExpenseControlApp());
    expect(find.byType(Text), findsNWidgets(1));
  });
}

import 'package:expense_control_app/data/model/category.dart';
import 'package:expense_control_app/main.dart';
import 'package:expense_control_app/presentation/widgets/date_filter_categories_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  setUp(() async {
    // expenseBloc = ExpenseBloc();
    await Hive.initFlutter();

    //Hive.registerAdapter<Expense>(ExpenseAdapter());
    Hive.registerAdapter<Category>(CategoryAdapter());
    //late Box<Expense> _expensesHive;
    Box<Category> _categoriesHive = await Hive.openBox<Category>('categories');

    //_categoriesHive = await Hive.openBox<Category>('categories');
    //_expensesHive = await Hive.openBox<Expense>('expenses');

    //await _categoriesHive.clear();
    //await _expensesHive.clear();
    //
    // await _categoriesHive.add(_category);
    // await _expensesHive.add(_expenses[0]);
    // await _expensesHive.add(_expenses[1]);
    // await _expensesHive.add(_expenses[2]);
    // await _expensesHive.add(_expenses[3]);

    // expenseBloc = ExpenseBloc();
  });

  testWidgets('widget exists', (WidgetTester tester) async {
    await tester.pumpWidget(ExpenseControlApp());
    expect(find.byType(FloatingActionButton), findsNWidgets(1));
  });
}

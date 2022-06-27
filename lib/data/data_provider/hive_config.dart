import 'package:expense_control_app/data/model/filter_date_time.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../model/category.dart';
import '../model/expense.dart';

class HiveConfig {
  const HiveConfig._();

  /// Handles all the setup for Hive
  static Future<void> setup() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Category>(CategoryAdapter());
    Hive.registerAdapter<Expense>(ExpenseAdapter());
    Hive.registerAdapter<FilterDateTime>(FilterDateTimeAdapter());

    await Hive.openBox<Category>('categories');
    await Hive.openBox<Expense>('expenses');
    await Hive.openBox<FilterDateTime>('filter_date_time');
  }

  static get categoriesBox {
    return Hive.box<Category>('categories');
  }

  static get expensesBox {
    return Hive.box<Expense>('expenses');
  }

  static get filterRangeBox {
    return Hive.box<FilterDateTime>('filter_date_time');
  }

  /// Closes all the opened hive boxes
  Future<void> kill() => Hive.close();
}

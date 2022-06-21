import 'package:expense_control_app/business_logic/blocs/category_bloc/category_bloc.dart';
import 'package:expense_control_app/data/model/filter_date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'business_logic/blocs/expense_bloc/expense_bloc.dart';
import 'business_logic/blocs/filter_date_time_bloc/filter_date_time_bloc.dart';
import 'data/data_provider/category_data.dart';
import 'data/data_provider/expense_data.dart';
import 'data/data_provider/filter_date_time_data.dart';
import 'data/model/category.dart';
import 'data/model/expense.dart';
import 'presentation/screens/categories_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Category>(CategoryAdapter());
  Hive.registerAdapter<Expense>(ExpenseAdapter());
  Hive.registerAdapter<FilterDateTime>(FilterDateTimeAdapter());
  final CategoryData _categoryData = CategoryData();
  final ExpenseData _expenseData = ExpenseData();
  final FilterDateTimeData _filterDateTimeData = FilterDateTimeData();
  _categoryData.init;
  _expenseData.init;
  _filterDateTimeData.init;
  runApp(const ExpenseControlApp());
}

class ExpenseControlApp extends StatelessWidget {
  const ExpenseControlApp({Key? key}) : super(key: key);
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => ExpenseBloc()),
        BlocProvider(create: (context) => FilterDateTimeBloc()),
      ],
      child: ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (_, ThemeMode currentMode, __) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.amber),
              darkTheme: ThemeData.dark(),
              themeMode: currentMode,
              title: 'Expense Control',
              home: Scaffold(
                  appBar: AppBar(
                    title: Text('Expense Control'),
                    actions: [
                      IconButton(
                          icon: Icon(ExpenseControlApp.themeNotifier.value ==
                                  ThemeMode.light
                              ? Icons.dark_mode
                              : Icons.light_mode),
                          onPressed: () {
                            ExpenseControlApp.themeNotifier.value =
                                ExpenseControlApp.themeNotifier.value ==
                                        ThemeMode.light
                                    ? ThemeMode.dark
                                    : ThemeMode.light;
                          })
                    ],
                  ),
                  body: CategoriesScreen()),
            );
          }),
    );
  }
}

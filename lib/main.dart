import 'package:expense_control_app/business_logic/blocs/category_bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/blocs/expense_bloc/expense_bloc.dart';
import 'business_logic/blocs/filter_date_time_bloc/filter_date_time_bloc.dart';
import 'data/data_provider/hive_config.dart';
import 'presentation/screens/categories_screen.dart';

void main() async {
  await HiveConfig.setup();
  runApp(const ExpenseControlApp());
}

class ExpenseControlApp extends StatelessWidget {
  const ExpenseControlApp({Key? key}) : super(key: key);
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
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
              title: 'Expense control',
              home: CategoriesScreen(),
            );
          }),
    );
  }
}

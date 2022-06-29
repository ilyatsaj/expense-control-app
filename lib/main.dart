import 'package:expense_control_app/business_logic/cubits/category_cubit/category_cubit.dart';
import 'package:expense_control_app/business_logic/cubits/filter_date_time_cubit/filter_date_time_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/cubits/expense_cubit/expense_cubit.dart';
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
        BlocProvider(create: (context) => CategoryCubit()..getCategories()),
        BlocProvider(create: (context) => ExpenseCubit()),
        BlocProvider(create: (context) => FilterDateTimeCubit()),
        // BlocProvider(create: (context) => CategoryBloc()),
        // BlocProvider(create: (context) => ExpenseBloc()),
        // BlocProvider(create: (context) => FilterDateTimeBloc()),
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

import 'package:expense_control_app/business_logic/blocs/category_bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'business_logic/blocs/expense_bloc/expense_bloc.dart';
import 'data/data_provider/category_data.dart';
import 'data/data_provider/expense_data.dart';
import 'data/model/category.dart';
import 'data/model/expense.dart';
import 'presentation/screens/categories_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Category>(CategoryAdapter());
  Hive.registerAdapter<Expense>(ExpenseAdapter());
  // await Hive.openBox<Category>('categories');
  // await Hive.openBox<Expense>('expenses');
  final CategoryData _categoryData = CategoryData();
  final ExpenseData _expenseData = ExpenseData();
  _categoryData.init;
  _expenseData.init;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => ExpenseBloc()),
      ],
      child: MaterialApp(
        title: 'Expense control',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Expense control'),
            ),
            body: CategoriesScreen()),
      ),
    );
  }
}

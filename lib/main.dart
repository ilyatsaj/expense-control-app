import 'package:flutter/material.dart';

import 'presentation/screens/categories_screen.dart';

void main() {
  //await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense control',
      home: CategoriesScreen(),
    );
  }
}

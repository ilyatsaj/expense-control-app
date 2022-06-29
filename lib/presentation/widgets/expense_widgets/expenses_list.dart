import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/cubits/expense_cubit/expense_cubit.dart';
import '../../../data/model/category.dart';
import 'expense_tile.dart';

class ExpensesList extends StatefulWidget {
  final Category category;
  final DateTimeRange dateTimeRange;

  const ExpensesList(
      {Key? key, required this.category, required this.dateTimeRange})
      : super(key: key);
  @override
  ExpensesListState createState() => ExpensesListState();
}

class ExpensesListState extends State<ExpensesList> {
  ExpenseCubit? _expenseCubit;
  @override
  void initState() {
    super.initState();
    _expenseCubit = context.read<ExpenseCubit>()..getExpenses(widget.category);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      bloc: _expenseCubit,
      builder: (context, state) {
        if (state is ExpenseLoaded) {
          return ListView.builder(
            itemCount: state.expenses!.length,
            itemBuilder: (context, index) {
              return ExpenseTile(
                category: widget.category,
                expense: state.expenses![index],
                dateTimeRange: widget.dateTimeRange,
              );
            },
          );
        } else if (state is ExpenseLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Text('Error in expenses (custom)');
        }
      },
    );
  }
}

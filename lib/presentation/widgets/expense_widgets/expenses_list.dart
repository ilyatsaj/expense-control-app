import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/blocs/expense_bloc/expense_bloc.dart';
import '../../../data/model/category.dart';
import 'expense_tile.dart';

class ExpensesList extends StatefulWidget {
  final Category category;
  final DateTimeRange dateTimeRange;

  const ExpensesList(
      {Key? key, required this.category, required this.dateTimeRange})
      : super(key: key);
  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  ExpenseBloc? _expenseBloc;
  @override
  void initState() {
    super.initState();
    _expenseBloc = BlocProvider.of<ExpenseBloc>(context)
      ..add(GetExpenses(widget.category, widget.dateTimeRange));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      bloc: _expenseBloc,
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

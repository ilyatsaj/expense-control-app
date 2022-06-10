import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/expense_bloc/expense_bloc.dart';
import 'expense_tile.dart';

class ExpensesList extends StatefulWidget {
  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  ExpenseBloc? _expenseBloc;
  @override
  void initState() {
    super.initState();
    _expenseBloc = BlocProvider.of<ExpenseBloc>(context)..add(GetExpenses());
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
        if (state is Loaded) {
          return ListView.builder(
            itemCount: state.expenses!.length,
            itemBuilder: (context, index) {
              return ExpenseTile(
                expense: state.expenses![index],
                // name: state.categories![index].name,
                // totalAmount: state.categories![index].totalAmount,
                // iconData: state.categories![index].iconData,
              );
            },
          );
        } else if (state is LoadingFailure) {
          return const Text('Error in categories (custom)');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

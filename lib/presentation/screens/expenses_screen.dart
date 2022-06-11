import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/expense_bloc/expense_bloc.dart';
import '../../data/model/category.dart';
import '../../data/model/expense.dart';
import '../widgets/create_new_expense_widget.dart';
import '../widgets/expenses_list.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({Key? key, required this.category}) : super(key: key);
  final Category category;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Expense control'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final expense = Expense(
                categoryId: category.id!, name: '', description: '', amount: 0);
            final result = await showDialog<Expense>(
                context: context,
                builder: (context) => Dialog(
                      child: CreateNewExpenseWidget(expense: expense),
                    ));

            if (result != null) {
              BlocProvider.of<ExpenseBloc>(context)
                  .add(AddExpense(category, result));
            }
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            Container(),
            Expanded(
              child: ExpensesList(
                category: category,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../business_logic/cubits/expense_cubit/expense_cubit.dart';
import '../../../constants.dart';
import '../../../data/model/category.dart';
import '../../../data/model/expense.dart';
import 'create_new_expense_widget.dart';

class ExpenseTile extends StatelessWidget {
  ExpenseTile(
      {required this.category,
      required this.expense,
      required this.dateTimeRange});
  final Expense expense;
  final Category category;
  final DateTimeRange dateTimeRange;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseCubit(),
      child: ListTile(
        leading: expense.iconData != null
            ? Icon(IconData(expense.iconData!, fontFamily: 'MaterialIcons'))
            : Icon(null),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    expense.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${DateFormat.yMd().format(expense.dc)}',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Text('${expense.amount} \$'),
          ],
        ),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            icon: new Icon(Icons.edit),
            highlightColor: Colors.grey,
            onPressed: () async {
              final result = await showDialog<Expense>(
                  context: context,
                  builder: (context) => Dialog(
                        child: CreateUpdateExpenseWidget(expense: expense),
                      ));

              if (result != null) {
                // BlocProvider.of<ExpenseBloc>(context)
                //     .add(UpdateExpense(category, result));
                // BlocProvider.of<ExpenseBloc>(context)
                //     .add(GetExpenses(category, dateTimeRange));
                context.read<ExpenseCubit>().updateExpense(result);
                context.read<ExpenseCubit>().getExpenses(category);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            highlightColor: Colors.grey,
            onPressed: () async {
              _delete(context);
            },
          ),
        ]),
      ),
    );
  }

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: kDeleteConfirmBox,
            actions: [
              TextButton(
                  onPressed: () {
                    // BlocProvider.of<ExpenseBloc>(context)
                    //     .add(DeleteExpense(expense, category));
                    // BlocProvider.of<ExpenseBloc>(context)
                    //     .add(GetExpenses(category, dateTimeRange));
                    context
                        .read<ExpenseCubit>()
                        .deleteExpense(category, expense);
                    context.read<ExpenseCubit>().getExpenses(category);
                    Navigator.pop(context);
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.pop(context);
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}

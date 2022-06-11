import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/expense_bloc/expense_bloc.dart';
import '../../data/model/category.dart';
import '../../data/model/expense.dart';
import 'create_new_expense_widget.dart';

class ExpenseTile extends StatelessWidget {
  ExpenseTile({
    required this.category,
    required this.expense,
  });
  final Expense expense;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseBloc(),
      child: ListTile(
        leading: expense.iconData != null
            ? Icon(IconData(expense.iconData!, fontFamily: 'MaterialIcons'))
            : Icon(null),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(expense.name),
            Text('${expense.amount} \$'),
          ],
        ),
        //subtitle: Text(expense.amount.toString()),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            icon: new Icon(Icons.edit),
            highlightColor: Colors.grey,
            onPressed: () async {
              final result = await showDialog<Expense>(
                  context: context,
                  builder: (context) => Dialog(
                        child: CreateNewExpenseWidget(expense: expense),
                      ));

              if (result != null) {
                BlocProvider.of<ExpenseBloc>(context)
                    .add(UpdateExpense(category, result));
              }
            },
          ),
          IconButton(
            icon: new Icon(Icons.delete),
            highlightColor: Colors.grey,
            onPressed: () {
              BlocProvider.of<ExpenseBloc>(context)
                  .add(DeleteExpense(expense, category));
            },
          ),
        ]),
        // onLongPress: () {
        //   longPressCallback(name);
        // },
      ),
    );
  }
}

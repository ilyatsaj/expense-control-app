import 'package:expense_control_app/business_logic/blocs/category_bloc/category_bloc.dart';
import 'package:expense_control_app/helpers/date_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/expense_bloc/expense_bloc.dart';
import '../../data/model/category.dart';
import '../../data/model/expense.dart';
import '../widgets/create_new_expense_widget.dart';
import '../widgets/date_filter_widget.dart';
import '../widgets/expenses_list.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({Key? key, required this.category}) : super(key: key);
  final Category category;
  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    initFilter();
  }

  void initFilter() async {
    _selectedDateRange = await DateHelper.getFilterRange();
    print("data tut");
    print(_selectedDateRange?.start.toString());
    print(_selectedDateRange?.end.toString());
  }

// class ExpensesScreen extends StatelessWidget {
//   const ExpensesScreen({Key? key, required this.category}) : super(key: key);
//   final Category category;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Expense control'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final expense = Expense(
                categoryId: widget.category.id!,
                name: '',
                description: '',
                amount: 0,
                dc: DateTime.now());
            final result = await showDialog<Expense>(
                context: context,
                builder: (context) => Dialog(
                      child: CreateNewExpenseWidget(expense: expense),
                    ));

            if (result != null) {
              BlocProvider.of<ExpenseBloc>(context)
                  .add(AddExpense(widget.category, result));
            }
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            Container(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<CategoryBloc>(context)
                          .add(GetCategories(null));
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Expanded(child: Text('Expenses')),
                ],
              ),
            ),
            DateFilterWidget(selectedDateRange: _selectedDateRange),
            Expanded(
              child: ExpensesList(
                category: widget.category,
              ),
            )
          ],
        ),
      ),
    );
  }
}

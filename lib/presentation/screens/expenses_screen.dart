import 'package:expense_control_app/business_logic/blocs/category_bloc/category_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/expense_bloc/expense_bloc.dart';
import '../../data/model/category.dart';
import '../../data/model/expense.dart';
import '../widgets/expense_widgets/create_new_expense_widget.dart';
import '../widgets/date_filter_expenses_widget.dart';
import '../widgets/expense_widgets/expenses_list.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen(
      {Key? key, required this.category, required this.selectedDateRange})
      : super(key: key);
  final Category category;
  final DateTimeRange selectedDateRange;
  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ExpenseBloc>(context)
        .add(GetExpenses(widget.category, widget.selectedDateRange));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: CreateUpdateExpenseWidget(expense: expense),
                  ));
          print('here');
          if (result != null) {
            print('here2');
            print(widget.category.name);
            print(result.name);
            BlocProvider.of<ExpenseBloc>(context)
                .add(AddExpense(widget.category, result));
            BlocProvider.of<ExpenseBloc>(context)
                .add(GetExpenses(widget.category, widget.selectedDateRange));
          }
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Text(
                widget.category.name,
                style: TextStyle(fontSize: 20),
              ),
              margin: EdgeInsets.all(10)),
          Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(GetCategories(widget.selectedDateRange));
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Expanded(child: Text('Expenses')),
              ],
            ),
          ),
          DateFilterExpensesWidget(),
          Expanded(
            child: ExpensesList(
              category: widget.category,
              dateTimeRange: widget.selectedDateRange,
            ),
          ),
          BlocBuilder<ExpenseBloc, ExpenseState>(
            builder: (context, state) {
              if (state is ExpenseLoaded) {
                return Container(
                    margin: EdgeInsets.only(
                        top: 10,
                        bottom: 80,
                        left: 30,
                        right: 20), //symmetric(horizontal: 30, vertical: 70),
                    child: Text('Total: ${state.totalSum} \$'));
              } else if (state is CategoryLoading) {
                return CircularProgressIndicator();
              } else {
                return Container();
                //return const Text('Error in filters (expenses_screen)');
              }
            },
          ),
        ],
      ),
    );
  }
}

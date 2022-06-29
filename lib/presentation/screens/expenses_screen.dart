import 'package:expense_control_app/business_logic/cubits/category_cubit/category_cubit.dart';
import 'package:expense_control_app/business_logic/cubits/expense_cubit/expense_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/model/category.dart';
import '../../data/model/expense.dart';
import '../../themes.dart';
import '../widgets/expense_widgets/create_new_expense_widget.dart';
import '../widgets/date_filter_expenses_widget.dart';
import '../widgets/expense_widgets/expenses_list.dart';
import '../widgets/shared_widgets/total_sum_widget.dart';

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
    //context.read<ExpenseCubit>().getExpenses(widget.category);
    // BlocProvider.of<ExpenseBloc>(context)
    //     .add(GetExpenses(widget.category, widget.selectedDateRange));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Expense control',
            style: GoogleFonts.faustina(
                textStyle: Theme.of(context).textTheme.headline5!)),
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
          if (result != null) {
            context.read<ExpenseCubit>().addExpense(widget.category, result);
            context.read<ExpenseCubit>().getExpenses(widget.category);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.all(5),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<CategoryCubit>().getCategories();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    iconSize: 20,
                  ),
                  Text(
                    widget.category.name,
                    style: GoogleFonts.caveat(
                        textStyle: Theme.of(context).textTheme.headline4!),
                  ),
                ],
              )),
          DateFilterExpensesWidget(),
          Expanded(
            child: ExpensesList(
              category: widget.category,
              dateTimeRange: widget.selectedDateRange,
            ),
          ),
          BlocBuilder<ExpenseCubit, ExpenseState>(
            builder: (context, state) {
              if (state is ExpenseLoaded) {
                return Container(
                  margin: kTotalSumMargin,
                  child: TotalSumWidget(totalSum: state.totalSum),
                );
              } else if (state is CategoryLoading) {
                return const CircularProgressIndicator();
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

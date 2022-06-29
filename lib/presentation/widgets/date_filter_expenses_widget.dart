import 'package:expense_control_app/helpers/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubits/expense_cubit/expense_cubit.dart';
import '../../business_logic/cubits/filter_date_time_cubit/filter_date_time_cubit.dart';
import '../../constants.dart';
import '../../main.dart';
import '../../themes.dart';

class DateFilterExpensesWidget extends StatefulWidget {
  const DateFilterExpensesWidget({Key? key}) : super(key: key);

  @override
  DateFilterExpensesWidgetState createState() =>
      DateFilterExpensesWidgetState();
}

class DateFilterExpensesWidgetState extends State<DateFilterExpensesWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: BlocBuilder<ExpenseCubit, ExpenseState>(builder: (context, state) {
        if (state is ExpenseLoaded) {
          return InkWell(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: kFilterLabel,
                  ),
                  BlocBuilder<FilterDateTimeCubit, FilterDateTimeState>(
                      builder: (context, state) {
                    if (state is FilterLoaded) {
                      return Text(
                          DateHelper.dateRangeToFormattedString(
                              state.dateTimeRange),
                          style: TextStyle(
                              color: ExpenseControlApp.themeNotifier.value ==
                                      ThemeMode.light
                                  ? kColorAmberCustom[600]
                                  : kColorCyanCustom));
                    } else if (state is FilterLoading) {
                      return const Center(
                        child: LinearProgressIndicator(),
                      );
                    } else {
                      return const Text(
                          'Error in filters (date_filter_expenses_widget)');
                    }
                  }),
                ],
              ),
              onTap: () async {
                final result = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2022, 1, 1),
                  lastDate: DateTime(2030, 12, 31),
                  currentDate: DateTime.now(),
                  saveText: kSaveButtonText,
                );
                if (result != null) {
                  context.read<FilterDateTimeCubit>().setFilterDateTime(result);
                }
                context.read<ExpenseCubit>().getExpenses(state.category);
                context.read<FilterDateTimeCubit>().getFilterDateTime();
              });
        } else if (state is ExpenseLoading) {
          return LinearProgressIndicator();
        } else {
          return const Text('Error in get category for filter');
        }
      }),
    );
  }
}

import 'package:expense_control_app/business_logic/blocs/filter_date_time_bloc/filter_date_time_bloc.dart';
import 'package:expense_control_app/helpers/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/expense_bloc/expense_bloc.dart';
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
      child: BlocBuilder<ExpenseBloc, ExpenseState>(builder: (context, state) {
        if (state is ExpenseLoaded) {
          return InkWell(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: kFilterLabel,
                ),
                BlocBuilder<FilterDateTimeBloc, FilterDateTimeState>(
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
              BlocProvider.of<ExpenseBloc>(context)
                  .add(GetExpenses(state.category, result));
              BlocProvider.of<FilterDateTimeBloc>(context)
                  .add(SetFilterDateTime(result!));
              BlocProvider.of<FilterDateTimeBloc>(context)
                  .add(GetFilterDateTime());
              // Navigator.pop(context);
            },
          );
        } else if (state is ExpenseLoading) {
          return LinearProgressIndicator();
        } else {
          return const Text('Error in get category for filter');
        }
      }),
    );
  }
}

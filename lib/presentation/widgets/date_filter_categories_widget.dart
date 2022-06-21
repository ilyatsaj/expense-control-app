import 'package:expense_control_app/business_logic/blocs/filter_date_time_bloc/filter_date_time_bloc.dart';
import 'package:expense_control_app/helpers/date_helper.dart';
import 'package:expense_control_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/category_bloc/category_bloc.dart';
import '../../themes.dart';

class DateFilterCategoriesWidget extends StatefulWidget {
  DateFilterCategoriesWidget({Key? key}) : super(key: key);

  @override
  _DateFilterCategoriesWidgetState createState() =>
      _DateFilterCategoriesWidgetState();
}

class _DateFilterCategoriesWidgetState
    extends State<DateFilterCategoriesWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: InkWell(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Text(
                'Filter: ',
                style: kGreyTextStyle,
              ),
            ),
            BlocBuilder<FilterDateTimeBloc, FilterDateTimeState>(
                builder: (context, state) {
              if (state is FilterLoaded) {
                return Text(
                    DateHelper.dateRangeToFormattedString(state.dateTimeRange),
                    style: TextStyle(
                        color: ExpenseControlApp.themeNotifier.value ==
                                ThemeMode.light
                            ? Colors.amber[600]
                            : Color(0xFF64FFDA)));
              } else if (state is FilterLoading) {
                return Container();
              } else {
                return const Text(
                    'Error in filters (date_filter_categories_widget)');
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
            saveText: 'Save',
          );
          BlocProvider.of<CategoryBloc>(context)..add(GetCategories(result));
          BlocProvider.of<FilterDateTimeBloc>(context)
              .add(SetFilterDateTime(result!));
          BlocProvider.of<FilterDateTimeBloc>(context).add(GetFilterDateTime());
        },
      ),
    );
  }
}

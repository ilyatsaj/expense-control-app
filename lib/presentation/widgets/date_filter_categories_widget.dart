import 'package:expense_control_app/business_logic/blocs/filter_date_time_bloc/filter_date_time_bloc.dart';
import 'package:expense_control_app/helpers/date_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/category_bloc/category_bloc.dart';
import '../../data/model/category.dart';
import '../../themes.dart';

class DateFilterCategoriesWidget extends StatefulWidget {
  DateTimeRange? selectedDateRange;
  Category? category;
  DateFilterCategoriesWidget(
      {required this.selectedDateRange, this.category, Key? key})
      : super(key: key);

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
                    DateHelper.selectedDateRangeString(state.dateTimeRange),
                    style: TextStyle(color: Colors.blue));
              } else if (state is FilterLoading) {
                return const Center(
                  child: LinearProgressIndicator(),
                );
              } else {
                return const Text('Error in filters (custom)');
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

// Text(
// _filterBloc,
// style: TextStyle(color: Colors.blue),

import 'package:expense_control_app/helpers/date_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../business_logic/blocs/category_bloc/category_bloc.dart';
import '../../themes.dart';

class DateFilterWidget extends StatefulWidget {
  DateTimeRange? selectedDateRange;
  DateFilterWidget({required this.selectedDateRange, Key? key})
      : super(key: key);

  @override
  _DateFilterWidgetState createState() => _DateFilterWidgetState();
}

class _DateFilterWidgetState extends State<DateFilterWidget> {
  @override
  void initState() {
    super.initState();
    initFilter();
  }

  void initFilter() async {
    widget.selectedDateRange = await DateHelper.getFilterRange();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: InkWell(
        child: Row(
          children: [
            const Text(
              'Filter: ',
              style: kGreyTextStyle,
            ),
            Text(
              DateHelper.selectedDateRangeString(widget.selectedDateRange),
              style: TextStyle(color: Colors.blue),
            ),
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
          final prefs = await SharedPreferences.getInstance();

          if (result != null) {
            setState(() {
              widget.selectedDateRange = result;
            });
            await prefs.setString('filter_start', result.start.toString());
            await prefs.setString('filter_end', result.end.toString());
          }
          print('${result?.start} - ${result?.end}');
          BlocProvider.of<CategoryBloc>(context).add(GetCategories(result));
          // Navigator.pop(context);
        },
      ),
    );
  }
}

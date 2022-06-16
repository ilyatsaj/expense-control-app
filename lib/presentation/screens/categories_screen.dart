import 'package:expense_control_app/business_logic/blocs/category_bloc/category_bloc.dart';
import 'package:expense_control_app/presentation/widgets/date_filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/category.dart';
import '../../helpers/date_helper.dart';
import '../widgets/categories_list.dart';
import '../widgets/create_new_category_widget.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  DateTimeRange? _selectedDateRange;

  @override
  void initState() {
    super.initState();
    initFilter();
  }

  void initFilter() async {
    _selectedDateRange = await DateHelper.getFilterRange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final category = Category(
              name: '', description: '', totalAmount: 0, dc: DateTime.now());
          final result = await showDialog<Category>(
              context: context,
              builder: (context) => Dialog(
                    child: CreateNewCategoryWidget(category: category),
                  ));

          if (result != null) {
            BlocProvider.of<CategoryBloc>(context).add(AddCategory(result));
            BlocProvider.of<CategoryBloc>(context)
                .add(GetCategories(await DateHelper.getFilterRange()));
          }
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text('Categories'),
          ),
          DateFilterWidget(
              selectedDateRange:
                  DateHelper.selectedDateRangeDT(_selectedDateRange)),
          Expanded(
            child: CategoriesList(
              selectedDateRange: _selectedDateRange,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:expense_control_app/business_logic/blocs/category_bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/blocs/filter_date_time_bloc/filter_date_time_bloc.dart';
import '../../data/model/category.dart';
import '../../helpers/date_helper.dart';
import '../widgets/category_widgets/categories_list.dart';
import '../widgets/category_widgets/create_new_category_widget.dart';
import '../widgets/date_filter_categories_widget.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  DateTimeRange? _selectedDateRange;
  FilterDateTimeBloc? _filterBloc;

  @override
  void initState() {
    super.initState();
    _filterBloc = BlocProvider.of<FilterDateTimeBloc>(context)
      ..add(GetFilterDateTime());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Category>(
              context: context,
              builder: (context) => Dialog(
                    child: CreateNewCategoryWidget(
                        category: Category(
                            name: '',
                            description: '',
                            totalAmount: 0,
                            dc: DateTime.now())),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text('Categories'),
          ),
          BlocBuilder<FilterDateTimeBloc, FilterDateTimeState>(
              bloc: _filterBloc,
              builder: (context, state) {
                if (state is FilterLoaded) {
                  return DateFilterCategoriesWidget(
                      selectedDateRange: state.dateTimeRange);
                } else if (state is FilterLoading) {
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                } else {
                  return const Text('Error in filters (custom)');
                }
              }),
          Expanded(
            child: CategoriesList(
              selectedDateRange: _selectedDateRange,
            ),
          ),
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryLoaded) {
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
                return const Text('Error in filters (custom)');
              }
            },
          ),
        ],
      ),
    );
  }
}

import 'package:expense_control_app/business_logic/blocs/category_bloc/category_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_tile.dart';

class CategoriesList extends StatefulWidget {
  DateTimeRange? selectedDateRange;
  CategoriesList({required DateTimeRange? selectedDateRange, Key? key})
      : super(key: key);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  CategoryBloc? _categoryBloc;
  @override
  void initState() {
    _categoryBloc = BlocProvider.of<CategoryBloc>(context)
      ..add(GetCategories(widget.selectedDateRange));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      bloc: _categoryBloc,
      builder: (context, state) {
        if (state is CategoryLoaded) {
          return ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: state.categories!.length,
            itemBuilder: (context, index) {
              return CategoryTile(
                category: state.categories![index],
                selectedDateRange: state.timeRange!,
              );
            },
          );
        } else if (state is CategoryLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Text('No items to display');
        }
      },
    );
  }
}

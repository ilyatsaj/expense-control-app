import 'package:expense_control_app/business_logic/blocs/category_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_tile.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  CategoryBloc? _categoryBloc;
  @override
  void initState() {
    super.initState();
    _categoryBloc = BlocProvider.of<CategoryBloc>(context)
      ..add(GetCategories());
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
        if (state is Loaded) {
          return ListView.builder(
            itemCount: state.categories!.length,
            itemBuilder: (context, index) {
              return CategoryTile(
                category: state.categories![index],
                name: state.categories![index].name,
                totalAmount: state.categories![index].totalAmount,
                iconData: state.categories![index].iconData,
              );
            },
          );
        } else if (state is LoadingFailure) {
          return const Text('Error in categories (custom)');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

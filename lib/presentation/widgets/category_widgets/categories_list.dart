import 'package:expense_control_app/business_logic/cubits/category_cubit/category_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_tile.dart';

class CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        print('entered BlocBuilder');
        if (state is CategoryLoaded) {
          print('entered Loaded in CategoryList');
          return ListView.builder(
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

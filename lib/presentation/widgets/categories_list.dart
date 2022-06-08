import 'package:expense_control_app/business_logic/blocs/category_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'CategoryTile.dart';

class CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            if (state is Loaded) {
              return CategoryTile(
                name: state.categories![index].name,
                totalAmount: state.categories![index].totalAmount,
                // longPressCallback: (name) {
                //   categoryData.updateCategory(category, name);
                // },
              );
            } else if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Text('Error in categories (custom)');
            }
          },
          //itemCount: ,
        );
      },
    );
  }
}

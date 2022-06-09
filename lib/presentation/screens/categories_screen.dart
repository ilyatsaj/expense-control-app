import 'package:expense_control_app/business_logic/blocs/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/category.dart';
import '../widgets/categories_list.dart';
import '../widgets/create_new_category_widget.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog<Category>(
              context: context,
              builder: (context) => const Dialog(
                    child: CreateNewCategoryWidget(),
                  ));

          if (result != null) {
            BlocProvider.of<CategoryBloc>(context).add(AddCategory(result));
          }
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(),
          Expanded(
            child: CategoriesList(),
          )
        ],
      ),
    );
  }
}

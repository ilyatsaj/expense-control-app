import 'package:expense_control_app/business_logic/blocs/category_bloc.dart';
import 'package:expense_control_app/data/repositories/CategoryRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/categories_list.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CategoryRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CategoryBloc>(
            create: (context) => CategoryBloc(
              categoryRepository: context.read<CategoryRepository>(),
            )..add(
                GetCategories(),
              ),
          ),
        ],
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
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
        ),
      ),
    );
  }
}

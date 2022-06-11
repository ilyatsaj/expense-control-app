import 'package:expense_control_app/presentation/widgets/create_new_category_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/category_bloc/category_bloc.dart';
import '../../data/model/category.dart';
import '../screens/expenses_screen.dart';

class CategoryTile extends StatelessWidget {
  CategoryTile({
    required this.category,
  });
  final Category category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          side: MaterialStateProperty.all(
            const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExpensesScreen(category: category)));
        },
        child: ListTile(
          leading:
              Icon(IconData(category.iconData!, fontFamily: 'MaterialIcons')),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category.name),
              Text('${category.totalAmount} \$'),
            ],
          ),
          //subtitle: Text(category.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: new Icon(Icons.edit),
                highlightColor: Colors.grey,
                onPressed: () async {
                  final result = await showDialog<Category>(
                      context: context,
                      builder: (context) => Dialog(
                            child: CreateNewCategoryWidget(category: category),
                          ));

                  if (result != null) {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(UpdateCategory(result));
                  }
                },
              ),
              IconButton(
                icon: new Icon(Icons.delete),
                highlightColor: Colors.grey,
                onPressed: () {
                  BlocProvider.of<CategoryBloc>(context)
                      .add(DeleteCategory(category));
                },
              ),
            ],
          ),
          // onLongPress: () {
          //   longPressCallback(name);
          // },
        ),
      ),
    );
  }
}

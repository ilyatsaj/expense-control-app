import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/blocs/category_bloc.dart';
import '../../data/model/category.dart';

class CategoryTile extends StatelessWidget {
  CategoryTile({
    required this.category,
    required this.name,
    required this.totalAmount,
  });
  final Category category;
  final String name;
  final int totalAmount;
  //final Function longPressCallback;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(),
      child: ListTile(
        leading: Icon(
          Icons.play_arrow,
        ),
        title: Text(name),
        subtitle: Text(totalAmount.toString()),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            icon: new Icon(Icons.edit),
            highlightColor: Colors.grey,
            onPressed: () {},
          ),
          IconButton(
            icon: new Icon(Icons.delete),
            highlightColor: Colors.grey,
            onPressed: () {
              BlocProvider.of<CategoryBloc>(context)
                  .add(DeleteCategory(category));
            },
          ),
        ]),
        // onLongPress: () {
        //   longPressCallback(name);
        // },
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  CategoryTile({
    required this.name,
    required this.totalAmount,
  });
  final String name;
  final int totalAmount;
  //final Function longPressCallback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        name,
      ),
      //trailing: Text('10 %'),
      // onLongPress: () {
      //   longPressCallback(name);
      // },
    );
  }
}

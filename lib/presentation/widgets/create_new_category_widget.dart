import 'package:expense_control_app/data/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewCategoryWidget extends StatefulWidget {
  const CreateNewCategoryWidget({Key? key}) : super(key: key);

  @override
  _CreateNewCategoryWidgetState createState() =>
      _CreateNewCategoryWidgetState();
}

class _CreateNewCategoryWidgetState extends State<CreateNewCategoryWidget> {
  final _nameInputController = TextEditingController();
  final _descriptionInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Category name"),
        TextField(
          controller: _nameInputController,
        ),
        Text("Category description"),
        TextField(
          controller: _descriptionInputController,
        ),
        ElevatedButton(
            onPressed: () {
              final category = Category(
                  name: _nameInputController.text,
                  description: _descriptionInputController.text,
                  totalAmount: 0);
              Navigator.of(context).pop(category);
            },
            child: Text('Save'))
      ],
    );
  }
}

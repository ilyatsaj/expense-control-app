import 'package:expense_control_app/data/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../icons.dart';
import '../../../main.dart';

class CreateNewCategoryWidget extends StatefulWidget {
  final Category? category;

  const CreateNewCategoryWidget({Key? key, this.category}) : super(key: key);

  @override
  _CreateNewCategoryWidgetState createState() =>
      _CreateNewCategoryWidgetState();
}

class _CreateNewCategoryWidgetState extends State<CreateNewCategoryWidget> {
  TextEditingController? _nameInputController;
  TextEditingController? _descriptionInputController;
  int? iconDataCodeLocal;
  bool _validate = false;
  @override
  void initState() {
    super.initState();
    _nameInputController =
        TextEditingController(text: widget.category?.name ?? '');
    _descriptionInputController =
        TextEditingController(text: widget.category?.description ?? '');
    iconDataCodeLocal = widget.category!.iconData;
  }

  @override
  void dispose() {
    _nameInputController?.dispose();
    _descriptionInputController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameInputController,
          decoration: InputDecoration(
            labelText: 'Category name',
            errorText: _validate ? 'Value Can\'t Be Empty' : null,
          ),
        ),
        TextField(
          controller: _descriptionInputController,
          decoration: const InputDecoration(
            labelText: 'Description',
          ),
        ),
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: _showIconGrid())),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                ExpenseControlApp.themeNotifier.value == ThemeMode.light
                    ? MaterialStateProperty.all<Color>(Colors.amber)
                    : MaterialStateProperty.all<Color>(Color(0xFF64FFDA)),
          ),
          onPressed: () async {
            final category = Category(
                id: widget.category?.id,
                name: _nameInputController!.text,
                description: _descriptionInputController!.text,
                totalAmount: 0,
                iconData: iconDataCodeLocal,
                dc: DateTime.now());
            setState(() {
              _nameInputController!.text.isEmpty
                  ? _validate = true
                  : _validate = false;
            });
            if (!_validate) Navigator.of(context).pop(category);
          },
          child: Text(
            'Save',
            style: TextStyle(
              color: ExpenseControlApp.themeNotifier.value == ThemeMode.light
                  ? Colors.black87
                  : Colors.black87,
            ),
          ),
        )
      ],
    );
  }

  _showIconGrid() {
    return GridView.count(
      crossAxisCount: 8,
      children: List.generate(icons.length, (index) {
        var iconData = icons[index];
        return IconButton(
          color: iconDataCodeLocal == null
              ? Colors.grey[600]
              : iconDataCodeLocal == iconData.codePoint
                  ? Colors.amber[600]
                  : Colors.grey[600],
          onPressed: () {
            setState(() {
              iconDataCodeLocal = iconData.codePoint;
            });
          },
          icon: Icon(
            iconData,
          ),
        );
      }),
    );
  }
}

import 'package:expense_control_app/data/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/model/expense.dart';

class CreateNewExpenseWidget extends StatefulWidget {
  final Expense? expense;

  const CreateNewExpenseWidget({Key? key, this.expense}) : super(key: key);

  @override
  _CreateNewExpenseWidgetState createState() => _CreateNewExpenseWidgetState();
}

class _CreateNewExpenseWidgetState extends State<CreateNewExpenseWidget> {
  TextEditingController? _nameInputController;
  TextEditingController? _descriptionInputController;
  bool isPressed = false;
  int? iconDataCodeLocal;
  @override
  void initState() {
    super.initState();
    _nameInputController =
        TextEditingController(text: widget.expense?.name ?? '');
    _descriptionInputController =
        TextEditingController(text: widget.expense?.description ?? '');
    iconDataCodeLocal = widget.expense!.iconData;
    widget.expense ?? Category(name: '', description: '', totalAmount: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Expense name"),
        TextField(
          controller: _nameInputController,
        ),
        Text("Expense description"),
        TextField(
          controller: _descriptionInputController,
        ),
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: _showIconGrid())),
        ElevatedButton(
            onPressed: () async {
              final expense = Expense(
                  id: widget.expense?.id,
                  categoryId: widget.expense!.categoryId,
                  name: _nameInputController!.text,
                  description: _descriptionInputController!.text,
                  amount: 0,
                  iconData: iconDataCodeLocal!);
              Navigator.of(context).pop(expense);
            },
            child: Text('Save'))
      ],
    );
  }

  _showIconGrid() {
    var ls = [
      Icons.web_asset,
      Icons.weekend,
      Icons.whatshot,
      Icons.widgets,
      Icons.wifi,
      Icons.wifi_lock,
      Icons.wifi_tethering,
      Icons.work,
      Icons.wrap_text,
      Icons.youtube_searched_for,
      Icons.zoom_in,
      Icons.zoom_out,
      Icons.zoom_out_map,
      Icons.restaurant_menu,
      Icons.restore,
      Icons.restore_from_trash,
      Icons.restore_page,
      Icons.ring_volume,
      Icons.room,
      Icons.exposure_zero,
      Icons.extension,
      Icons.face,
      Icons.fast_forward,
      Icons.fast_rewind,
      Icons.fastfood,
      Icons.favorite,
      Icons.favorite_border,
    ];

    return GridView.count(
      crossAxisCount: 8,
      children: List.generate(ls.length, (index) {
        var iconData = ls[index];
        return IconButton(
          color: iconDataCodeLocal == null
              ? Colors.grey[600]
              : iconDataCodeLocal == iconData.codePoint
                  ? Colors.orange
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

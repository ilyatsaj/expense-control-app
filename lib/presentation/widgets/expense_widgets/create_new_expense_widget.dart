import 'package:expense_control_app/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/model/expense.dart';
import '../../../main.dart';

class CreateUpdateExpenseWidget extends StatefulWidget {
  final Expense? expense;

  const CreateUpdateExpenseWidget({Key? key, this.expense}) : super(key: key);

  @override
  _CreateUpdateExpenseWidgetState createState() =>
      _CreateUpdateExpenseWidgetState();
}

class _CreateUpdateExpenseWidgetState extends State<CreateUpdateExpenseWidget> {
  TextEditingController? _nameInputController;
  TextEditingController? _descriptionInputController;
  TextEditingController? _amountInputController;
  int? _iconDataCodeLocal;
  bool _validate = false;
  @override
  void initState() {
    super.initState();
    _nameInputController =
        TextEditingController(text: widget.expense?.name ?? '');
    _descriptionInputController =
        TextEditingController(text: widget.expense?.description ?? '');
    _amountInputController =
        TextEditingController(text: widget.expense?.amount.toString() ?? '');
    _iconDataCodeLocal = widget.expense!.iconData;
  }

  @override
  void dispose() {
    _nameInputController?.dispose();
    _descriptionInputController?.dispose();
    _amountInputController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5, left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
            iconSize: 20,
          ),
          TextField(
            controller: _nameInputController,
            decoration: InputDecoration(
              labelText: 'Expense name',
              errorText: _validate ? 'Value Can\'t Be Empty' : null,
            ),
          ),
          TextField(
            controller: _descriptionInputController,
            decoration: const InputDecoration(
              labelText: 'Description',
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: _amountInputController,
            decoration: const InputDecoration(
              labelText: 'Amount',
            ),
          ),
          Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: _showIconGrid())),
          Center(
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      ExpenseControlApp.themeNotifier.value == ThemeMode.light
                          ? MaterialStateProperty.all<Color>(Colors.amber)
                          : MaterialStateProperty.all<Color>(Color(0xFF64FFDA)),
                ),
                onPressed: () async {
                  final expense = Expense(
                      id: widget.expense?.id,
                      categoryId: widget.expense!.categoryId,
                      name: _nameInputController!.text,
                      description: _descriptionInputController!.text,
                      amount: int.parse(_amountInputController!.text),
                      iconData: _iconDataCodeLocal,
                      dc: widget.expense!.dc);
                  setState(() {
                    _nameInputController!.text.isEmpty
                        ? _validate = true
                        : _validate = false;
                  });
                  if (!_validate) Navigator.of(context).pop(expense);
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color:
                        ExpenseControlApp.themeNotifier.value == ThemeMode.light
                            ? Colors.black87
                            : Colors.black87,
                  ),
                )),
          )
        ],
      ),
    );
  }

  _showIconGrid() {
    return GridView.count(
      crossAxisCount: 8,
      children: List.generate(icons.length, (index) {
        var iconData = icons[index];
        return IconButton(
          color: _iconDataCodeLocal == null
              ? Colors.grey[600]
              : _iconDataCodeLocal == iconData.codePoint
                  ? Colors.amber[600]
                  : Colors.grey[600],
          onPressed: () {
            setState(() {
              _iconDataCodeLocal = iconData.codePoint;
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

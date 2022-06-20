import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../data/model/expense.dart';

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
    return Column(
      children: [
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
        ElevatedButton(
            onPressed: () async {
              print('entered create upd expense');
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
          color: _iconDataCodeLocal == null
              ? Colors.grey[600]
              : _iconDataCodeLocal == iconData.codePoint
                  ? Colors.orange
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

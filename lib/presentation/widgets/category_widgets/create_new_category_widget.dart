import 'package:expense_control_app/data/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  bool isPressed = false;
  int? iconDataCodeLocal;
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
        Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: _showIconGrid())),
        ElevatedButton(
            onPressed: () async {
              final category = Category(
                  id: widget.category?.id,
                  name: _nameInputController!.text,
                  description: _descriptionInputController!.text,
                  totalAmount: 0,
                  iconData: iconDataCodeLocal,
                  dc: DateTime.now());
              Navigator.of(context).pop(category);
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

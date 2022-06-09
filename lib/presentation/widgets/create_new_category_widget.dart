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
  int? iconDataCode;
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
            onPressed: () {
              final category = Category(
                  name: _nameInputController.text,
                  description: _descriptionInputController.text,
                  totalAmount: 0,
                  iconData: iconDataCode!);
              print(category.iconData);
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
            highlightColor: Colors.blueAccent,
            onPressed: () {
              iconDataCode = iconData.codePoint;
            },
            icon: Icon(
              iconData,
            ));
      }),
    );
  }
}

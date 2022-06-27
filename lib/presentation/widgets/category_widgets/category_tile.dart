import 'package:expense_control_app/presentation/widgets/category_widgets/create_new_category_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../business_logic/blocs/category_bloc/category_bloc.dart';
import '../../../constants.dart';
import '../../../data/model/category.dart';
import '../../screens/expenses_screen.dart';

class CategoryTile extends StatelessWidget {
  CategoryTile({required this.category, required this.selectedDateRange});
  final Category category;
  final DateTimeRange selectedDateRange;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc(),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExpensesScreen(
                        category: category,
                        selectedDateRange: selectedDateRange,
                      )));
        },
        child: ListTile(
          //dense: true,
          //visualDensity: VisualDensity(horizontal: 5),
          minLeadingWidth: 1,
          leading: category.iconData != null
              ? Icon(IconData(category.iconData!, fontFamily: 'MaterialIcons'))
              : const Icon(null),
          title: Container(
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        category.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${DateFormat.yMd().format(category.dc!)}',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text('${category.totalAmount} \$'),
              ],
            ),
          ),
          //subtitle: Text('${DateFormat.yMd().format(category.dc)}'),
          trailing: SizedBox(
            //width: 80,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: new Icon(Icons.edit),
                  highlightColor: Colors.grey,
                  onPressed: () async {
                    final result = await showDialog<Category>(
                        context: context,
                        builder: (context) => Dialog(
                              child:
                                  CreateNewCategoryWidget(category: category),
                            ));

                    if (result != null) {
                      BlocProvider.of<CategoryBloc>(context)
                          .add(UpdateCategory(result));
                      BlocProvider.of<CategoryBloc>(context)
                          .add(GetCategories(selectedDateRange));
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  highlightColor: Colors.grey,
                  onPressed: () async {
                    _delete(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: kDeleteConfirmBox,
            actions: [
              TextButton(
                  onPressed: () {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(DeleteCategory(category));
                    BlocProvider.of<CategoryBloc>(context)
                        .add(GetCategories(selectedDateRange));
                    Navigator.pop(context);
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.pop(context);
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}

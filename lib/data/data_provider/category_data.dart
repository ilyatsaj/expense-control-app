import 'package:expense_control_app/data/data_provider/hive_config.dart';
import 'package:hive/hive.dart';

import '../model/category.dart';

class CategoryData {
  final Box<Category> _categoriesHive = HiveConfig.categoriesBox;

  Future<List<Category>> getAll() async {
    print('getAll cat');
    final categories = _categoriesHive.values;
    print('cat length: ' + categories.toList().length.toString());
    return categories.toList();
  }

  Future<void> addCategory(Category category) async {
    print('entered DB method');
    if (_categoriesHive.values.isNotEmpty) {
      print('if entered');
      category.id = _categoriesHive.values.last.id == null
          ? null
          : _categoriesHive.values.last.id! + 1;
      print('cat id');
      print(category.id);
    } else {
      print('else entered');
      category.id = 0;
    }
    category.dc ??= DateTime.now();
    _categoriesHive.add(category);
  }

  Future<void> updateCategory(Category category) async {
    final categoryToUpdate = _categoriesHive.values
        .firstWhere((element) => element.id == category.id);
    categoryToUpdate.name = category.name;
    categoryToUpdate.description = category.description;
    categoryToUpdate.iconData = category.iconData;
    categoryToUpdate.save();
  }

  Future<void> removeCategory(Category category) async {
    final categoryToRemove = _categoriesHive.values
        .firstWhere((element) => element.id == category.id);
    categoryToRemove.delete();
  }
}

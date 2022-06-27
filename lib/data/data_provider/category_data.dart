import 'package:expense_control_app/data/data_provider/hive_config.dart';
import 'package:hive/hive.dart';

import '../model/category.dart';

class CategoryData {
  final Box<Category> _categoriesHive = HiveConfig.categoriesBox;

  Future<List<Category>> getAll() async {
    final categories = _categoriesHive.values;
    return categories.toList();
  }

  Future<void> addCategory(Category category) async {
    if (_categoriesHive.values.isNotEmpty) {
      category.id = _categoriesHive.values.last.id == null
          ? null
          : _categoriesHive.values.last.id! + 1;
    } else {
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
    await categoryToUpdate.save();
  }

  Future<void> removeCategory(Category category) async {
    final categoryToRemove = _categoriesHive.values
        .firstWhere((element) => element.id == category.id);
    await categoryToRemove.delete();
  }
}

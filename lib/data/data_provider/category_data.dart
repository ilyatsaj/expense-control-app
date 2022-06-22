import 'package:hive/hive.dart';

import '../model/category.dart';

class CategoryData {
  late Box<Category> _categoriesHive;

  Future<void> init() async {
    _categoriesHive = await Hive.openBox<Category>('categories');
  }

  Future<List<Category>> getAll() async {
    _categoriesHive = await Hive.openBox<Category>('categories');
    final categories = _categoriesHive.values;

    return categories.toList();
  }

  Future<void> addCategory(Category category) async {
    _categoriesHive = await Hive.openBox<Category>('categories');
    if (_categoriesHive.values.isNotEmpty) {
      category.id = _categoriesHive.values.last.id == null
          ? null
          : _categoriesHive.values.last.id! + 1;
    } else {
      category.id = 0;
    }
    _categoriesHive.add(category);
  }

  Future<void> updateCategory(Category category) async {
    _categoriesHive = await Hive.openBox<Category>('categories');
    final categoryToUpdate = _categoriesHive.values
        .firstWhere((element) => element.id == category.id);
    categoryToUpdate.name = category.name;
    categoryToUpdate.description = category.description;
    categoryToUpdate.iconData = category.iconData;
    await categoryToUpdate.save();
  }

  Future<void> removeCategory(Category category) async {
    _categoriesHive = await Hive.openBox<Category>('categories');
    final categoryToRemove = _categoriesHive.values
        .firstWhere((element) => element.name == category.name);
    await categoryToRemove.delete();
  }
}

import 'package:hive/hive.dart';

import '../model/category.dart';

class CategoryData {
  final List<Category> _categories = [
    Category(
        id: 0,
        name: 'food',
        description: 'descr1',
        totalAmount: 0,
        iconData: 61665,
        dc: DateTime.now()),
    Category(
        id: 1,
        name: 'plane',
        description: 'descr2',
        totalAmount: 35,
        iconData: 61668,
        dc: DateTime.now()),
    Category(
        id: 2,
        name: 'book',
        description: 'descr3',
        totalAmount: 4,
        iconData: 61667,
        dc: DateTime.now())
  ];

  late Box<Category> _categoriesHive;

  Future<void> init() async {
    _categoriesHive = await Hive.openBox<Category>('categories');

    // await _categoriesHive.clear();
    // await _categoriesHive.add(_categories[0]);
    // await _categoriesHive.add(_categories[1]);
    // await _categoriesHive.add(_categories[2]);
  }

  Future<List<Category>> getAll() async {
    _categoriesHive = await Hive.openBox<Category>('categories');
    //await Future.delayed(Duration(seconds: 1));
    final categories = _categoriesHive.values;

    return categories.toList();
  }

  Future<void> addCategory(Category category) async {
    _categoriesHive = await Hive.openBox<Category>('categories');
    if (!_categoriesHive.values.isEmpty) {
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

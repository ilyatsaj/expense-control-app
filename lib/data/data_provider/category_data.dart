import 'package:hive/hive.dart';

import '../model/category.dart';

class CategoryData {
  final List<Category> _categories = [
    Category(
        id: 0,
        name: 'food',
        description: 'descr1',
        totalAmount: 0,
        iconData: 61665),
    Category(
        id: 1,
        name: 'plane',
        description: 'descr2',
        totalAmount: 35,
        iconData: 61668),
    Category(
        id: 2,
        name: 'book',
        description: 'descr3',
        totalAmount: 15,
        iconData: 61667)
  ];

  late Box<Category> _categoriesHive;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter<Category>(CategoryAdapter());
    }

    _categoriesHive = await Hive.openBox<Category>('categories');

    await _categoriesHive.clear();

    await _categoriesHive.add(_categories[0]);
    await _categoriesHive.add(_categories[1]);
    await _categoriesHive.add(_categories[2]);
    //print(_categoriesHive.values.first.iconData);
  }

  Future<List<Category>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    final categories = _categoriesHive.values;
    print('KEYS!');
    print(categories.first.key);
    print(categories.last.key);

    return categories.toList();
  }

  Future<void> addCategory(Category category) async {
    print('_categoriesHive.values.last.id: ${_categoriesHive.values.last.id}');
    category.id = _categoriesHive.values.last.id == null
        ? null
        : _categoriesHive.values.last.id! + 1;
    print('category.id: ${category.id}');
    _categoriesHive.add(category);
  }

  Future<void> updateCategory(Category category) async {
    print('RECEIVED!');
    print(category.id);
    print(category.name);
    print(category.description);
    print(category.iconData);

    //final categoryToUpdate = _categoriesHive.get(category.key);
    final categoryToUpdate = _categoriesHive.values
        .firstWhere((element) => element.id == category.id);
    print('GET! categoryToUpdate');
    print(categoryToUpdate.id);
    print(categoryToUpdate.name);
    print(categoryToUpdate.description);
    print(categoryToUpdate.iconData);
    categoryToUpdate.name = category.name;
    categoryToUpdate.description = category.description;
    categoryToUpdate.totalAmount = category.totalAmount;
    categoryToUpdate.iconData = category.iconData;
    await categoryToUpdate.save();
  }

  Future<void> removeCategory(Category category) async {
    final categoryToRemove = _categoriesHive.values
        .firstWhere((element) => element.name == category.name);
    await categoryToRemove.delete();
    //_categories.remove(category);
  }
}

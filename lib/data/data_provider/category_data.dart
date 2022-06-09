import 'package:hive/hive.dart';

import '../model/category.dart';

class CategoryData {
  final List<Category> _categories = [
    Category(name: 'food', description: 'descr1', totalAmount: 0),
    Category(name: 'plane', description: 'descr2', totalAmount: 35),
    Category(name: 'book', description: 'descr3', totalAmount: 15)
  ];

  late Box<Category> _categoriesHive;

  Future<void> init() async {
    Hive.registerAdapter(CategoryAdapter());
    _categoriesHive = await Hive.openBox<Category>('categories');

    await _categoriesHive.clear();

    await _categoriesHive.add(_categories[0]);
    await _categoriesHive.add(_categories[1]);
    await _categoriesHive.add(_categories[2]);
  }

  Future<List<Category>> getAll() async {
    await Future.delayed(Duration(seconds: 1));
    final categories = _categoriesHive.values;
    return categories.toList();
  }

  Future<void> addCategory(Category category) async {
    print('heeeeeee: ' + category.name);
    print('heeeeeee: ' + category.description);
    print('heeeeeee: ' + category.totalAmount.toString());
    _categoriesHive.add(category);
  }

  int get categoryLength {
    return _categoriesHive.length;
  }

  void updateCategory(Category category, String newName) {
    //category.set(newName);
  }

  Future<void> removeCategory(Category category) async {
    final categoryToRemove = _categoriesHive.values
        .firstWhere((element) => element.name == category.name);
    await categoryToRemove.delete();
    //_categories.remove(category);
  }
}

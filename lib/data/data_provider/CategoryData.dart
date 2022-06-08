import '../model/Category.dart';

class CategoryData {
  final List<Category> _categories = [
    Category(name: 'food', totalAmount: 0),
    Category(name: 'plane', totalAmount: 35)
  ];

  // void initRepository() async {
  //   var path = Directory.current.path;
  //   Hive
  //     ..init(path)
  //     ..registerAdapter(CategoryAdapter());
  //
  //   var box = await Hive.openBox('testBox');
  //
  //   var category = Category(
  //     name: 'Transport',
  //     totalAmount: 0,
  //   );
  //
  //   await box.put('Transport', category);
  //
  //   print(box.get('Transport')); //
  // }

  Future<List<Category>> get() async {
    await Future.delayed(Duration(seconds: 2));
    return _categories;
  }

  void addCategory(String name) {
    _categories.add(Category(name: name, totalAmount: 0));
  }

  int get categoryLength {
    return _categories.length;
  }

  void updateCategory(Category category, String newName) {
    category.set(newName);
  }

  void removeCategory(Category category) {
    _categories.remove(category);
  }
}

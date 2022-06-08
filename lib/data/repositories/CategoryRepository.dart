import '../data_provider/CategoryData.dart';
import '../model/Category.dart';

class CategoryRepository {
  final CategoryData categoryData = CategoryData();
  Future<List<Category>> getCategories() async {
    final categories = await categoryData.get();
    return categories;
  }
}

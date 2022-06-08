import '../data_provider/CategoryData.dart';
import '../model/Category.dart';

class CategoryRepository {
  late final CategoryData categoryData;
  Future<List<Category>> getCategories() async {
    final categories = await categoryData.get();
    return categories;
  }
}

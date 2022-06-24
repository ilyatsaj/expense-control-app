import 'package:expense_control_app/data/data_provider/category_data.dart';
import 'package:expense_control_app/data/model/category.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/mockito.dart';

class MockCategoryData extends Mock implements CategoryData {}

//@GenerateMocks([MockCategoryData])
void main() {
  group('Category Hive tests', () {
    MockCategoryData mockCategoryData;
    setUp(() async {
      Category category = Category(
          name: 'testName',
          description: 'testDescr',
          totalAmount: 0,
          dc: DateTime.now());
      await setUpTestHive();
      final box = await Hive.openBox<Category>('categories');
      Hive.registerAdapter(CategoryAdapter());
      //await box.add(category);
      mockCategoryData = MockCategoryData();
    });

    test('getAll categories', () async {
      mockCategoryData = MockCategoryData();
      var list = await mockCategoryData.getAll();
      print(list);
      assert(list == Future<List<Category>>);
    });
  });
}

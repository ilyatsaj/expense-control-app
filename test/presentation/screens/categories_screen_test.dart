import 'package:expense_control_app/business_logic/blocs/filter_date_time_bloc/filter_date_time_bloc.dart';
import 'package:expense_control_app/data/model/category.dart';
import 'package:expense_control_app/main.dart';
import 'package:expense_control_app/presentation/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mockito/mockito.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  MockBuildContext _mockContext;
  setUp(() async {
    Category category = Category(
        name: 'testName',
        description: 'testDescr',
        totalAmount: 0,
        dc: DateTime.now());

    await setUpTestHive();
    final box = await Hive.openBox<Category>('categories');
    Hive.registerAdapter(CategoryAdapter());
    await box.add(category);
    _mockContext = MockBuildContext();
    FilterDateTimeBloc bloc = FilterDateTimeBloc();
    BlocProvider.of<FilterDateTimeBloc>(_mockContext).add(GetFilterDateTime());
  });

  tearDown(() async {
    // await tearDownTestHive();
  });
  group('Category screen elements exist check', () {
    testWidgets('Categories label exists on screen page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        _TestWidget(
          child: Scaffold(
            body: Column(
              children: [
                Center(
                  child: Text('Categories'),
                ),
              ],
            ),
          ),
        ),
      );
      expect(find.text('Categories'), findsOneWidget);
    });
  });

  testWidgets('FloatingActionButton exists on screen page',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      _TestWidget(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
          ),
        ),
      ),
    );

    await tester.pumpWidget(CategoriesScreen());
    //await tester.pumpAndSettle();
    expect(find.byType(FloatingActionButton), findsNWidgets(1));
  });
}

class _TestWidget extends StatelessWidget {
  const _TestWidget({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) => MaterialApp(home: child);
}

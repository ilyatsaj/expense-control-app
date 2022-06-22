import 'package:bloc_test/bloc_test.dart';
import 'package:expense_control_app/business_logic/blocs/expense_bloc/expense_bloc.dart';
import 'package:expense_control_app/data/model/category.dart';
import 'package:expense_control_app/data/model/expense.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test/test.dart';

void main() {
  final Category _category = Category(
      name: 'test',
      description: 'test',
      totalAmount: 5,
      dc: DateTime(2022, 5, 5));

  final List<Expense> expenses = [
    Expense(
        id: 0,
        categoryId: 0,
        name: 'potato',
        description: 'descr1',
        amount: 5,
        iconData: 61665,
        dc: DateTime.now()),
    Expense(
        id: 1,
        categoryId: 0,
        name: 'tomato',
        description: 'descr2',
        amount: 25,
        iconData: 61668,
        dc: DateTime.now()),
    Expense(
        id: 2,
        categoryId: 0,
        name: 'cucumber',
        description: 'descr3',
        amount: 10,
        iconData: 61667,
        dc: DateTime.now()),
    Expense(
        id: 3,
        categoryId: 0,
        name: 'Harry Potter book',
        description: 'descr3',
        amount: 3,
        iconData: 61667,
        dc: DateTime.now()),
  ];

  group('ExpenseBloc test', () {
    // late ExpenseBloc expenseBloc;

    setUp(() async {
      // expenseBloc = ExpenseBloc();
      await Hive.initFlutter();

      Hive.registerAdapter<Expense>(ExpenseAdapter());
      Hive.registerAdapter<Category>(CategoryAdapter());
      late Box<Expense> _expensesHive;
      late Box<Category> _categoriesHive;

      _categoriesHive = await Hive.openBox<Category>('categories');
      _expensesHive = await Hive.openBox<Expense>('expenses');

      await _categoriesHive.clear();
      await _expensesHive.clear();
      //
      await _categoriesHive.add(_category);
      await _expensesHive.add(expenses[0]);
      await _expensesHive.add(expenses[1]);
      await _expensesHive.add(expenses[2]);
      await _expensesHive.add(expenses[3]);

      // expenseBloc = ExpenseBloc();
    });

    blocTest<ExpenseBloc, ExpenseState>(
      'emits [ExpenseLoading, ExpenseLoaded] states for'
      'successful expense loads',
      build: () => ExpenseBloc(),
      act: (bloc) => bloc.on<GetExpenses>((event, emit) => null),
      expect: () => [
        ExpenseLoading(),
        ExpenseLoaded(expenses: expenses, category: _category, totalSum: 43),
      ],
    );

    // blocTest<ExpenseBloc, ExpenseState>(
    //   'emits [TaskLoadInProgress, TaskLoadSuccess] with correct urgent tasks',
    //   build: () => expenseBloc,
    //   act: (cubit) => cubit.getUrgentTasks(),
    //   expect: () => [
    //     TaskLoadInProgress(),
    //     TaskLoadSuccess(const [
    //       Task(id: '4', title: 'Task 4', isUrgent: true),
    //       Task(id: '7', title: 'Task 7', isUrgent: true),
    //       Task(id: '9', title: 'Task 9', isUrgent: true),
    //       Task(id: '10', title: 'Task 10', isUrgent: true),
    //     ]),
    //   ],
    // );

    // tearDown(() {
    //   expenseBloc.close();
    // });
  });
}

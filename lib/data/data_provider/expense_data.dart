import 'package:hive/hive.dart';
import '../model/category.dart';
import '../model/expense.dart';

class ExpenseData {
  final List<Expense> _expenses = [
    Expense(
        id: 0,
        categoryId: 1,
        name: 'potato',
        description: 'descr1',
        amount: 2,
        iconData: 61665,
        dc: DateTime.now()),
    Expense(
        id: 1,
        categoryId: 1,
        name: 'tomato',
        description: 'descr2',
        amount: 35,
        iconData: 61668,
        dc: DateTime.now()),
    Expense(
        id: 2,
        categoryId: 1,
        name: 'cucumber',
        description: 'descr3',
        amount: 15,
        iconData: 61667,
        dc: DateTime.now()),
    Expense(
        id: 3,
        categoryId: 2,
        name: 'Harry Potter book',
        description: 'descr3',
        amount: 4,
        iconData: 61667,
        dc: DateTime.now()),
  ];

  late Box<Expense> _expensesHive;
  late Box<Category> _categoriesHive;

  Future<void> init() async {
    _expensesHive = await Hive.openBox<Expense>('expenses');
    _categoriesHive = await Hive.openBox<Category>('categories');

    // await _expensesHive.clear();
    //
    // await _expensesHive.add(_expenses[0]);
    // await _expensesHive.add(_expenses[1]);
    // await _expensesHive.add(_expenses[2]);
    // await _expensesHive.add(_expenses[3]);
  }

  Future<List<Expense>> getAll(Category category) async {
    //await Future.delayed(Duration(seconds: 1));
    final expenses = _expensesHive.values
        .where((element) => element.categoryId == category.id)
        .toList();
    return expenses;
  }

  Future<void> addExpense(Expense expense, Category category) async {
    if (!_expensesHive.values.isEmpty) {
      expense.id = _expensesHive.values.last.id == null
          ? null
          : _expensesHive.values.last.id! + 1;
    } else {
      expense.id = 0;
    }

    _expensesHive.add(expense);

    Box<Category> categoriesHive = await Hive.openBox<Category>('categories');
    final categoryToUpdate = categoriesHive.values
        .firstWhere((element) => element.id == category.id);
    categoryToUpdate.totalAmount = category.totalAmount + expense.amount;
    await categoryToUpdate.save();
  }

  Future<void> updateExpense(Expense expense) async {
    final expenseToUpdate =
        _expensesHive.values.firstWhere((element) => element.id == expense.id);
    expenseToUpdate.name = expense.name;
    expenseToUpdate.description = expense.description;
    expenseToUpdate.amount = expense.amount;
    expenseToUpdate.iconData = expense.iconData;
    await expenseToUpdate.save();
  }

  Future<void> removeExpense(Expense expense, Category category) async {
    final expenseToRemove = _expensesHive.values
        .firstWhere((element) => element.name == expense.name);
    await expenseToRemove.delete();
    Box<Category> categoriesHive = await Hive.openBox<Category>('categories');
    final categoryToUpdate = categoriesHive.values
        .firstWhere((element) => element.id == category.id);
    categoryToUpdate.totalAmount = category.totalAmount - expense.amount;
    await categoryToUpdate.save();
  }

  Future<Category> getCategoryById(double categoryId) async {
    _categoriesHive = await Hive.openBox<Category>('categories');
    final Category category = _categoriesHive.values
        .firstWhere((element) => element.id == categoryId);
    return category;
  }
}

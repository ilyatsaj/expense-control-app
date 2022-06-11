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
        iconData: 61665),
    Expense(
        id: 1,
        categoryId: 1,
        name: 'tomato',
        description: 'descr2',
        amount: 35,
        iconData: 61668),
    Expense(
        id: 2,
        categoryId: 1,
        name: 'cucumber',
        description: 'descr3',
        amount: 15,
        iconData: 61667),
    Expense(
        id: 3,
        categoryId: 2,
        name: 'Harry Potter book',
        description: 'descr3',
        amount: 4,
        iconData: 61667)
  ];

  late Box<Expense> _expensesHive;

  Future<void> init() async {
    _expensesHive = await Hive.openBox<Expense>('expenses');

    // await _expensesHive.clear();
    //
    // await _expensesHive.add(_expenses[0]);
    // await _expensesHive.add(_expenses[1]);
    // await _expensesHive.add(_expenses[2]);
    // await _expensesHive.add(_expenses[3]);
  }

  Future<List<Expense>> getAll(Category category) async {
    await Future.delayed(Duration(seconds: 1));
    final expenses = _expensesHive.values
        .where((element) => element.categoryId == category.id)
        .toList();

    return expenses;
  }

  Future<void> addExpense(Expense expense) async {
    print('ENTERED addExpense');
    print(expense.id);
    print(expense.categoryId);
    print(expense.name);
    print(expense.description);
    print(expense.amount);
    expense.id = _expensesHive.values.last.id == null
        ? null
        : _expensesHive.values.last.id! + 1;
    _expensesHive.add(expense);
    print('AFTER ADDING addExpense');
    print(expense.id);
    print(expense.categoryId);
    print(expense.name);
    print(expense.description);
    print(expense.amount);
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

  Future<void> removeExpense(Expense expense) async {
    final expenseToRemove = _expensesHive.values
        .firstWhere((element) => element.name == expense.name);
    await expenseToRemove.delete();
    //_categories.remove(category);
  }
}

import 'package:hive/hive.dart';
import '../model/category.dart';
import '../model/expense.dart';

class ExpenseData {
  late Box<Expense> _expensesHive;

  Future<void> init() async {
    _expensesHive = await Hive.openBox<Expense>('expenses');
  }

  Future<List<Expense>?> getAll(Category category) async {
    _expensesHive = await Hive.openBox<Expense>('expenses');
    final expenses = _expensesHive.values
        .where((element) => element.categoryId == category.id);

    return expenses.toList();
  }

  Future<void> addExpense(Expense expense, Category category) async {
    if (_expensesHive.values.isNotEmpty) {
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

  Future<void> removeNestedExpenses(Category category) async {
    final expensesToRemove = _expensesHive.values
        .where((element) => element.categoryId == category.id);
    for (var expense in expensesToRemove) {
      await expense.delete();
    }
  }
}

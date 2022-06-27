import 'package:expense_control_app/data/data_provider/hive_config.dart';
import 'package:hive/hive.dart';
import '../model/category.dart';
import '../model/expense.dart';

class ExpenseData {
  final Box<Expense> _expensesHive = HiveConfig.expensesBox;
  final Box<Category> _categoriesHive = HiveConfig.categoriesBox;

  Future<List<Expense>?> getAll(Category category) async {
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

    final categoryToUpdate = _categoriesHive.values
        .firstWhere((element) => element.id == category.id);
    categoryToUpdate.totalAmount = category.totalAmount! + expense.amount;
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

    final categoryToUpdate = _categoriesHive.values
        .firstWhere((element) => element.id == category.id);
    categoryToUpdate.totalAmount = category.totalAmount! - expense.amount;
    await categoryToUpdate.save();
  }

  Future<void> removeNestedExpenses(Category category) async {
    final expensesToRemove = _expensesHive.values
        .where((element) => element.categoryId == category.id);
    if (expensesToRemove.isNotEmpty) {
      for (var expense in expensesToRemove) {
        await expense.delete();
      }
    }
  }
}

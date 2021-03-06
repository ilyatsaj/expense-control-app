part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetExpenses extends ExpenseEvent {
  final Category category;
  final DateTimeRange? dateTimeRange;
  GetExpenses(this.category, this.dateTimeRange);
}

class DeleteExpense extends ExpenseEvent {
  final Category category;
  final Expense expense;
  DeleteExpense(this.expense, this.category);
}

class DeleteAllNestedExpenses extends ExpenseEvent {
  final Category category;
  DeleteAllNestedExpenses(this.category);
}

class AddExpense extends ExpenseEvent {
  final Category category;
  final Expense expense;
  AddExpense(this.category, this.expense);
}

class UpdateExpense extends ExpenseEvent {
  final Category category;
  final Expense expense;
  UpdateExpense(this.category, this.expense);
}

class GetTotalSumExpenses extends ExpenseEvent {
  final DateTimeRange? dateTimeRange;
  GetTotalSumExpenses(this.dateTimeRange);
}

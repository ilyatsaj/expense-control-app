part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetExpenses extends ExpenseEvent {
  final Category category;
  GetExpenses(this.category);
}

class DeleteExpense extends ExpenseEvent {
  final Category category;
  final Expense expense;
  DeleteExpense(this.category, this.expense);
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

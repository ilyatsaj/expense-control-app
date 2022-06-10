part of 'expense_bloc.dart';

@immutable
abstract class ExpenseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetExpenses extends ExpenseEvent {
  GetExpenses();
}

class DeleteExpense extends ExpenseEvent {
  final Expense expense;
  DeleteExpense(this.expense);
}

class AddExpense extends ExpenseEvent {
  final Expense expense;
  AddExpense(this.expense);
}

class UpdateExpense extends ExpenseEvent {
  final Expense expense;
  UpdateExpense(this.expense);
}

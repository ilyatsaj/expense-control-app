part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class Loading extends ExpenseState {}

class Loaded extends ExpenseState {
  Loaded({required this.expenses, required this.category});
  List<Expense>? expenses;
  Category category;
}

class LoadingFailure extends ExpenseState {
  final String error;
  LoadingFailure({required this.error});
}

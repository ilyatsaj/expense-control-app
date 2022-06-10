part of 'expense_bloc.dart';

@immutable
abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class Loading extends ExpenseState {}

class Loaded extends ExpenseState {
  Loaded({required this.expenses});
  List<Expense>? expenses;
}

class LoadingFailure extends ExpenseState {
  final String error;
  LoadingFailure({required this.error});
}

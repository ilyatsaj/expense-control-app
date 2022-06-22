part of 'expense_bloc.dart';

abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  ExpenseLoaded(
      {required this.expenses, required this.category, required this.totalSum});
  List<Expense>? expenses;
  Category category;
  int? totalSum;
}

class LoadingFailure extends ExpenseState {
  final String error;
  LoadingFailure({required this.error});
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/data_provider/expense_data.dart';
import '../../../data/data_provider/filter_date_time_data.dart';
import '../../../data/model/category.dart';
import '../../../data/model/expense.dart';

part 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseCubit() : super(ExpenseInitial());

  final ExpenseData _expenseData = ExpenseData();
  final FilterDateTimeData _filterData = FilterDateTimeData();

  Future<void> getExpenses(Category category) async {
    int totalSum = 0;
    emit(ExpenseLoading());
    try {
      List<Expense>? expenses = await _expenseData.getAll(category);
      DateTimeRange? dtr = await _filterData.getFilterDateTimeRange();
      if (expenses != null) {
        DateTime rangeStart =
            DateTime.utc(dtr.start.year, dtr.start.month, dtr.start.day);
        DateTime rangeEnd =
            DateTime.utc(dtr.end.year, dtr.end.month, dtr.end.day);

        expenses = expenses
            .where((element) =>
                DateTime.utc(element.dc.year, element.dc.month, element.dc.day)
                        .compareTo(rangeStart) ==
                    0 ||
                DateTime.utc(element.dc.year, element.dc.month, element.dc.day)
                        .compareTo(rangeEnd) ==
                    0 ||
                (DateTime.utc(element.dc.year, element.dc.month, element.dc.day)
                            .compareTo(rangeStart) >
                        0 &&
                    DateTime.utc(element.dc.year, element.dc.month,
                                element.dc.day)
                            .compareTo(rangeEnd) <
                        0))
            .toList();
        for (Expense e in expenses) {
          totalSum = totalSum + e.amount;
        }
      }
      emit(ExpenseLoaded(
          expenses: expenses, category: category, totalSum: totalSum));
    } catch (e) {
      emit(LoadingFailure(error: e.toString()));
    }
  }

  Future<void> deleteExpense(Category category, Expense expense) async {
    emit(ExpenseLoading());
    try {
      await _expenseData.removeExpense(expense, category);
    } catch (e) {
      emit(LoadingFailure(error: e.toString()));
    }
  }

  Future<void> deleteAllNestedExpenses(Category category) async {
    emit(ExpenseLoading());
    try {
      await _expenseData.removeNestedExpenses(category);
    } catch (e) {
      emit(LoadingFailure(error: e.toString()));
    }
  }

  Future<void> addExpense(Category category, Expense expense) async {
    emit(ExpenseLoading());
    try {
      print('expense.name: ' + expense.name);
      await _expenseData.addExpense(expense, category);
    } catch (e) {
      emit(LoadingFailure(error: e.toString()));
    }
  }

  Future<void> updateExpense(Expense expense) async {
    emit(ExpenseLoading());
    try {
      await _expenseData.updateExpense(expense);
    } catch (e) {
      emit(LoadingFailure(error: e.toString()));
    }
  }
}

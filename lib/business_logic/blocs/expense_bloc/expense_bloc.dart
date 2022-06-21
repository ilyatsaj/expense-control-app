import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/data_provider/expense_data.dart';
import '../../../data/data_provider/filter_date_time_data.dart';
import '../../../data/model/category.dart';
import '../../../data/model/expense.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseData _expenseData = ExpenseData();
  final FilterDateTimeData _filterData = FilterDateTimeData();

  ExpenseBloc() : super(ExpenseInitial()) {
    on<GetExpenses>((event, emit) async {
      print('are we here');
      _expenseData.init();
      _filterData.init();
      int totalSum = 0;
      emit(ExpenseLoading());
      try {
        List<Expense>? expenses = await _expenseData.getAll(event.category);
        DateTimeRange? dtr = await _filterData.getFilterDateTimeRange();
        if (dtr != null) {
          DateTime rangeStart =
              DateTime.utc(dtr.start.year, dtr.start.month, dtr.start.day);
          DateTime rangeEnd =
              DateTime.utc(dtr.end.year, dtr.end.month, dtr.end.day);

          expenses = expenses
              .where((element) =>
                  DateTime.utc(
                              element.dc.year, element.dc.month, element.dc.day)
                          .compareTo(rangeStart) ==
                      0 ||
                  DateTime.utc(
                              element.dc.year, element.dc.month, element.dc.day)
                          .compareTo(rangeEnd) ==
                      0 ||
                  (DateTime.utc(element.dc.year, element.dc.month,
                                  element.dc.day)
                              .compareTo(rangeStart) >
                          0 &&
                      DateTime.utc(element.dc.year, element.dc.month,
                                  element.dc.day)
                              .compareTo(rangeEnd) <
                          0))
              .toList();
        }
        if (expenses.isNotEmpty) {
          for (Expense e in expenses) {
            totalSum = totalSum + e.amount;
          }
        }
        emit(ExpenseLoaded(
            expenses: expenses, category: event.category, totalSum: totalSum));
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });
    on<DeleteExpense>((event, emit) async {
      emit(ExpenseLoading());
      try {
        await _expenseData.removeExpense(event.expense, event.category);
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });
    on<AddExpense>((event, emit) async {
      emit(ExpenseLoading());
      print('try to enter try');
      try {
        print('try to add');
        await _expenseData.addExpense(event.expense, event.category);
        print('added');
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });

    on<UpdateExpense>((event, emit) async {
      emit(ExpenseLoading());
      try {
        await _expenseData.updateExpense(event.expense);
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });
  }
}

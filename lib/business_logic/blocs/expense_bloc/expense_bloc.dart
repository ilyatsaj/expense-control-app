import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/data_provider/expense_data.dart';
import '../../../data/model/category.dart';
import '../../../data/model/expense.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseData _expenseData = ExpenseData();

  ExpenseBloc() : super(ExpenseInitial()) {
    on<GetExpenses>((event, emit) async {
      print('here we go 2');
      _expenseData.init();
      emit(Loading());
      try {
        List<Expense> expenses = await _expenseData.getAll(event.category);
        emit(Loaded(expenses: expenses));
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });
    on<DeleteExpense>((event, emit) async {
      print('here we go 1');
      emit(Loading());
      try {
        print('GATCHA');
        await _expenseData.removeExpense(event.expense, event.category);
        List<Expense> expenses = await _expenseData.getAll(event.category);
        emit(Loaded(expenses: expenses));
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });
    on<AddExpense>((event, emit) async {
      emit(Loading());
      try {
        await _expenseData.addExpense(event.expense, event.category);
        List<Expense> expenses = await _expenseData.getAll(event.category);
        emit(Loaded(expenses: expenses));
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });

    on<UpdateExpense>((event, emit) async {
      emit(Loading());
      try {
        await _expenseData.updateExpense(event.expense);
        List<Expense> expenses = await _expenseData.getAll(event.category);
        emit(Loaded(expenses: expenses));
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });

    // on<GetTotalPerCategory>((event, emit) async {
    //   emit(Loading());
    //   try {
    //     await _expenseData.getTotalAmountPerCategory(event.category);
    //     // List<Expense> expenses = await _expenseData.getAll(event.category);
    //     // emit(Loaded(expenses: expenses));
    //   } catch (e) {
    //     emit(LoadingFailure(error: e.toString()));
    //   }
    // });
  }
}
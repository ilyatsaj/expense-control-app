import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/data_provider/category_data.dart';
import '../../../data/data_provider/expense_data.dart';
import '../../../data/data_provider/filter_date_time_data.dart';
import '../../../data/model/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());

  final CategoryData _categoryData = CategoryData();
  final ExpenseData _expenseData = ExpenseData();
  final FilterDateTimeData _filterData = FilterDateTimeData();

  Future<void> getCategories() async {
    print('we are here');
    int totalSum = 0;
    emit(CategoryLoading());
    try {
      List<Category>? categories = await _categoryData.getAll();
      DateTimeRange? dtr = await _filterData.getFilterDateTimeRange();
      print('dtr: ' + dtr.toString());
      DateTime rangeStart =
          DateTime.utc(dtr.start.year, dtr.start.month, dtr.start.day);
      DateTime rangeEnd =
          DateTime.utc(dtr.end.year, dtr.end.month, dtr.end.day);
      categories = categories
          .where((element) =>
              DateTime.utc(element.dc!.year, element.dc!.month, element.dc!.day)
                      .compareTo(rangeStart) ==
                  0 ||
              DateTime.utc(element.dc!.year, element.dc!.month, element.dc!.day)
                      .compareTo(rangeEnd) ==
                  0 ||
              (DateTime.utc(element.dc!.year, element.dc!.month,
                              element.dc!.day)
                          .compareTo(rangeStart) >
                      0 &&
                  DateTime.utc(element.dc!.year, element.dc!.month,
                              element.dc!.day)
                          .compareTo(rangeEnd) <
                      0))
          .toList();
      if (categories.isNotEmpty) {
        print('categories to show');
        for (Category c in categories) {
          print(c.name);
          totalSum = totalSum + c.totalAmount!;
        }
      }
      emit(CategoryLoaded(
          categories: categories, timeRange: dtr, totalSum: totalSum));
    } catch (e) {
      emit(CategoryLoadingFailure(error: e.toString()));
    }
  }

  Future<void> deleteCategory(Category category) async {
    emit(CategoryLoading());
    try {
      _expenseData.removeNestedExpenses(category);
      _categoryData.removeCategory(category);
    } catch (e) {
      emit(CategoryLoadingFailure(error: e.toString()));
    }
  }

  Future<void> addCategory(Category category) async {
    print('entered addCategory');
    emit(CategoryLoading());
    try {
      _categoryData.addCategory(category);
    } catch (e) {
      emit(CategoryLoadingFailure(error: e.toString()));
    }
  }

  Future<void> updateCategory(Category category) async {
    emit(CategoryLoading());
    try {
      _categoryData.updateCategory(category);
    } catch (e) {
      emit(CategoryLoadingFailure(error: e.toString()));
    }
  }
}

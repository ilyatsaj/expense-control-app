import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_control_app/data/data_provider/category_data.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/data_provider/filter_date_time_data.dart';
import '../../../data/model/category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryData _categoryData = CategoryData();
  final FilterDateTimeData _filterData = FilterDateTimeData();

  CategoryBloc() : super(CategoryInitial()) {
    _categoryData.init();
    _filterData.init();
    on<GetCategories>((event, emit) async {
      int totalSum = 0;
      emit(CategoryLoading());
      try {
        List<Category>? categories = await _categoryData.getAll();
        DateTimeRange? dtr = await _filterData.getFilterDateTimeRange();
        print(dtr);
        if (dtr != null) {
          DateTime rangeStart =
              DateTime.utc(dtr.start.year, dtr.start.month, dtr.start.day);
          DateTime rangeEnd =
              DateTime.utc(dtr.end.year, dtr.end.month, dtr.end.day);

          categories = categories
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
        print('ooop');
        //print('1' + categories.first.name);
        if (categories.isNotEmpty) {
          for (Category c in categories) {
            totalSum = totalSum + c.totalAmount;
          }
        }
        print('total sum: ' + totalSum.toString());
        //print(categories.first.name);
        emit(CategoryLoaded(
            categories: categories, timeRange: dtr, totalSum: totalSum));
      } catch (e) {
        emit(CategoryLoadingFailure(error: e.toString()));
      }
    });
    on<DeleteCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await _categoryData.removeCategory(event.category);
      } catch (e) {
        emit(CategoryLoadingFailure(error: e.toString()));
      }
    });
    on<AddCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await _categoryData.addCategory(event.category);
      } catch (e) {
        emit(CategoryLoadingFailure(error: e.toString()));
      }
    });

    on<UpdateCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        await _categoryData.updateCategory(event.category);
      } catch (e) {
        emit(CategoryLoadingFailure(error: e.toString()));
      }
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/data_provider/filter_date_time_data.dart';

part 'filter_date_time_state.dart';

class FilterDateTimeCubit extends Cubit<FilterDateTimeState> {
  FilterDateTimeCubit() : super(FilterDateTimeInitial());

  final FilterDateTimeData _filterData = FilterDateTimeData();

  Future<void> getFilterDateTime() async {
    emit(FilterLoading());
    try {
      DateTimeRange dtr = await _filterData.getFilterDateTimeRange();
      emit(FilterLoaded(dateTimeRange: dtr));
    } catch (e) {
      emit(FilterLoadingFailure(error: e.toString()));
    }
  }

  Future<void> setFilterDateTime(DateTimeRange dateTimeRange) async {
    emit(FilterLoading());
    try {
      await _filterData.setFilterDateTime(dateTimeRange);
    } catch (e) {
      emit(FilterLoadingFailure(error: e.toString()));
    }
  }
}

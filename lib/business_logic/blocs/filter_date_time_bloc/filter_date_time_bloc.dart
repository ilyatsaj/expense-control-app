import 'package:bloc/bloc.dart';
import 'package:expense_control_app/data/data_provider/filter_date_time_data.dart';
import 'package:flutter/material.dart';

part 'filter_date_time_event.dart';
part 'filter_date_time_state.dart';

class FilterDateTimeBloc
    extends Bloc<FilterDateTimeEvent, FilterDateTimeState> {
  final FilterDateTimeData _filterData = FilterDateTimeData();
  FilterDateTimeBloc() : super(FilterDateTimeInitial()) {
    _filterData.init();
    on<GetFilterDateTime>((event, emit) async {
      emit(FilterLoading());
      try {
        DateTimeRange dtr = await _filterData.getFilterDateTimeRange();
        emit(FilterLoaded(dateTimeRange: dtr));
      } catch (e) {
        emit(FilterLoadingFailure(error: e.toString()));
      }
    });

    on<SetFilterDateTime>((event, emit) async {
      emit(FilterLoading());
      try {
        await _filterData.setFilterDateTime(event.dateTimeRange);
      } catch (e) {
        emit(FilterLoadingFailure(error: e.toString()));
      }
    });
  }
}

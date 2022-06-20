part of 'filter_date_time_bloc.dart';

abstract class FilterDateTimeState {}

class FilterDateTimeInitial extends FilterDateTimeState {}

class FilterLoading extends FilterDateTimeState {}

class FilterLoaded extends FilterDateTimeState {
  FilterLoaded({required this.dateTimeRange});
  DateTimeRange? dateTimeRange;
}

class FilterLoadingFailure extends FilterDateTimeState {
  final String error;
  FilterLoadingFailure({required this.error});
}

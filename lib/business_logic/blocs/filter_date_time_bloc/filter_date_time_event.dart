part of 'filter_date_time_bloc.dart';

abstract class FilterDateTimeEvent {
  const FilterDateTimeEvent();
}

class GetFilterDateTime extends FilterDateTimeEvent {}

class SetFilterDateTime extends FilterDateTimeEvent {
  final DateTimeRange dateTimeRange;
  SetFilterDateTime(this.dateTimeRange);
}

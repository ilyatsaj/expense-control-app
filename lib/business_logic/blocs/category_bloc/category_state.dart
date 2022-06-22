part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  CategoryLoaded(
      {required this.categories,
      required this.timeRange,
      required this.totalSum});
  List<Category>? categories;
  DateTimeRange? timeRange;
  int? totalSum;
}

class CategoryLoadingFailure extends CategoryState {
  final String error;
  CategoryLoadingFailure({required this.error});
}

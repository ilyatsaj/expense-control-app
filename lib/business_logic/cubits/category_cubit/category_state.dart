part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  CategoryLoaded(
      {required this.categories,
      required this.timeRange,
      required this.totalSum});
  final List<Category>? categories;
  final DateTimeRange? timeRange;
  final int? totalSum;
}

class CategoryLoadingFailure extends CategoryState {
  final String error;
  CategoryLoadingFailure({required this.error});
}

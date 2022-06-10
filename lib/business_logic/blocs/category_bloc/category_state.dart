part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class Loading extends CategoryState {}

class Loaded extends CategoryState {
  Loaded({required this.categories});
  List<Category>? categories;
}

class LoadingFailure extends CategoryState {
  final String error;
  LoadingFailure({required this.error});
}

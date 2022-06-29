part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategories extends CategoryEvent {
  //final DateTimeRange? dateTimeRange;
  //GetCategories(this.dateTimeRange);
  GetCategories();
}

class DeleteCategory extends CategoryEvent {
  final Category category;
  DeleteCategory(this.category);
}

class AddCategory extends CategoryEvent {
  final Category category;
  AddCategory(this.category);
}

class UpdateCategory extends CategoryEvent {
  final Category category;
  UpdateCategory(this.category);
}

class GetTotalSumCategories extends CategoryEvent {
  final DateTimeRange? dateTimeRange;
  GetTotalSumCategories(this.dateTimeRange);
}

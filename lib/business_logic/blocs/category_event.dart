part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategories extends CategoryEvent {
  GetCategories();
}

class DeleteCategory extends CategoryEvent {
  final Category category;
  DeleteCategory(this.category);
}

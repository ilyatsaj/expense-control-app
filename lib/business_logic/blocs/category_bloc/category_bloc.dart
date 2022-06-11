import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_control_app/data/data_provider/category_data.dart';
import 'package:meta/meta.dart';

import '../../../data/model/category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryData _categoryData = CategoryData();

  CategoryBloc() : super(CategoryInitial()) {
    _categoryData.init();
    on<GetCategories>((event, emit) async {
      emit(Loading());
      try {
        List<Category> categories = await _categoryData.getAll();
        emit(Loaded(categories: categories));
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });
    on<DeleteCategory>((event, emit) async {
      emit(Loading());
      try {
        await _categoryData.removeCategory(event.category);
        List<Category> categories = await _categoryData.getAll();
        emit(Loaded(categories: categories));
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });
    on<AddCategory>((event, emit) async {
      emit(Loading());
      try {
        await _categoryData.addCategory(event.category);
        List<Category> categories = await _categoryData.getAll();
        emit(Loaded(categories: categories));
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });

    on<UpdateCategory>((event, emit) async {
      emit(Loading());
      try {
        await _categoryData.updateCategory(event.category);
        List<Category> categories = await _categoryData.getAll();
        emit(Loaded(categories: categories));
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });
  }
}

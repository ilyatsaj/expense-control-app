import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/Category.dart';
import '../../data/repositories/CategoryRepository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final _categoryRepository = CategoryRepository();

  CategoryBloc() : super(CategoryInitial()) {
    on<GetCategories>((event, emit) async {
      emit(Loading());
      try {
        List<Category> categories = await _categoryRepository.getCategories();
        emit(Loaded(categories: categories));
      } catch (e) {
        emit(LoadingFailure(error: e.toString()));
      }
    });
  }

  // @override
  // Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
  //   if (event is GetCategories) {
  //     yield Loading();
  //     try {
  //       List<Category> categories = await _categoryRepository.getCategories();
  //       yield Loaded(categories: categories);
  //     } catch (e) {
  //       yield LoadingFailure(error: e.toString());
  //     }
  //   } else if (event is DeleteCategory) {
  //     try {
  //       // TODO: Delete category
  //       //await _categoryRepository.deletecategory(event.category.id);
  //       //yield Loaded(categories: await _categoryRepository.getCategories(query: event.query));
  //     } catch (e) {
  //       yield LoadingFailure(error: e.toString());
  //     }
  //   }
  // }
}

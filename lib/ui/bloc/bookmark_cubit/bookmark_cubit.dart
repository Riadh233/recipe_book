import 'package:bloc/bloc.dart';
import 'package:recipe_app/domain/usecases/is_recipe_bookmarked.dart';
import 'package:recipe_app/ui/bloc/bookmark_cubit/bookmark_state.dart';

import '../../../domain/model/recipe.dart';

class BookmarkCubit extends Cubit<BookmarkState>{
  BookmarkCubit(this._isRecipeBookmarked) : super(const BookmarkState(isBookmarked: false,status: BookmarkStatus.initial));
  final IsRecipeBookmarkedUseCase _isRecipeBookmarked;

  void isRecipeBookmarked(Recipe recipe) async {
    emit(state.copyWith(status: BookmarkStatus.initial));
    try{
      final isBookmarked = await _isRecipeBookmarked(params: recipe);
      emit(BookmarkState(isBookmarked: isBookmarked,status: BookmarkStatus.success));
    }on Exception catch(e){
      emit(state.copyWith(status: BookmarkStatus.failed));
    }
  }
  void bookmarked(){
    emit(const BookmarkState(isBookmarked: true,status: BookmarkStatus.success));
  }
  void unbookmarked(){
    emit(const BookmarkState(isBookmarked: false,status: BookmarkStatus.failed));
  }
}
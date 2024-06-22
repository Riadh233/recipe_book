import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_event.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_state.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';

import '../../../domain/model/recipe.dart';
import '../../../domain/usecases/bookmark_recipe.dart';
import '../../../domain/usecases/get_bookmarked_recipes.dart';

class FirestoreBloc extends Bloc<FirestoreEvent,RecipeBookmarkState>{
  final BookmarkRecipeUseCase _bookmarkRecipe;
  final GetBookmarkedRecipesUseCase _getBookmarkedRecipes;

  FirestoreBloc(this._bookmarkRecipe, this._getBookmarkedRecipes) : super(RecipeBookmarkState(const [], BookmarkStatus.initial,null)){
    on<BookmarkRecipeEvent>(_onBookmarkRecipe);
    on<GetBookmarkedRecipesEvent>(_onGetBookmarkedRecipes);
  }

  void _onBookmarkRecipe(BookmarkRecipeEvent event,Emitter<RecipeBookmarkState> emit) async{
    try{
      await _bookmarkRecipe(params: event.recipe);
      logger.log(Logger.level, 'recipe bookmarked');
      final List<Recipe>list = List.from(state.bookmarkedRecipes);
      emit(state.copyWith(bookmarkedRecipes: list..add(event.recipe),status: BookmarkStatus.success));
    }on Exception catch(e){
      emit(state.copyWith(status: BookmarkStatus.failed,error: 'bookmark failed'));
    }
  }
  void _onGetBookmarkedRecipes(GetBookmarkedRecipesEvent event,Emitter<RecipeBookmarkState> emit) async{
    try{
      final bookmarkedRecipes = await _getBookmarkedRecipes(params: 0);
      emit(state.copyWith(bookmarkedRecipes: bookmarkedRecipes,status: BookmarkStatus.success));
    }on Exception catch(e){
      emit(state.copyWith(status: BookmarkStatus.failed,error: 'could not load bookmarked recipes'));
    }
  }

}
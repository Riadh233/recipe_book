import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/domain/usecases/delete_all_bookmarks.dart';
import 'package:recipe_app/domain/usecases/unbookmark_recipe.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_event.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_state.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';

import '../../../domain/model/recipe.dart';
import '../../../domain/usecases/bookmark_recipe.dart';
import '../../../domain/usecases/get_bookmarked_recipes.dart';
import '../bookmark_cubit/bookmark_cubit.dart';

class FirestoreBloc extends Bloc<FirestoreEvent,RecipeBookmarkState>{
  final BookmarkRecipeUseCase _bookmarkRecipe;
  final GetBookmarkedRecipesUseCase _getBookmarkedRecipes;
  final UnbookmarkRecipeUseCase _unbookmarkRecipeUseCase;
  final DeleteAllBookmarksUseCase _deleteAllBookmarks;

  FirestoreBloc(this._bookmarkRecipe, this._getBookmarkedRecipes,this._unbookmarkRecipeUseCase, this._deleteAllBookmarks) : super(RecipeBookmarkState(const [], BookmarkFirestoreStatus.initial,null)){
    on<BookmarkRecipeEvent>(_onBookmarkRecipe);
    on<GetBookmarkedRecipesEvent>(_onGetBookmarkedRecipes);
    on<UnbookmarkRecipeEvent>(_onUnbookmarkRecipe);
    on<DeleteAllBookmarksEvent>(_onDeleteAllBookmarks);
  }

  void _onBookmarkRecipe(BookmarkRecipeEvent event,Emitter<RecipeBookmarkState> emit) async{
    try{
      emit(state.copyWith(status: BookmarkFirestoreStatus.initial));
      await _bookmarkRecipe(params: event.recipe);
      logger.log(Logger.level, 'recipe bookmarked');
      final List<Recipe>list = List.from(state.bookmarkedRecipes);
      emit(state.copyWith(bookmarkedRecipes: list..add(event.recipe),status: BookmarkFirestoreStatus.success));
    }on Exception catch(e){
      emit(state.copyWith(status: BookmarkFirestoreStatus.failed,error: 'bookmark failed'));
    }
  }
  void _onGetBookmarkedRecipes(GetBookmarkedRecipesEvent event,Emitter<RecipeBookmarkState> emit) async{
    try{
      final bookmarkedRecipes = await _getBookmarkedRecipes(params: 0);
      emit(state.copyWith(bookmarkedRecipes: bookmarkedRecipes,status: BookmarkFirestoreStatus.success));
    }on Exception catch(e){
      emit(state.copyWith(status: BookmarkFirestoreStatus.failed,error: 'could not load bookmarked recipes'));
    }
  }


  Future<void> _onUnbookmarkRecipe(UnbookmarkRecipeEvent event, Emitter<RecipeBookmarkState> emit) async{
    await _unbookmarkRecipeUseCase(params:event.recipe);
    final List<Recipe> bookmarkedRecipes = List.from(state.bookmarkedRecipes)..remove(event.recipe);
    emit(state.copyWith(bookmarkedRecipes: bookmarkedRecipes));
  }
  Future<void> _onDeleteAllBookmarks(DeleteAllBookmarksEvent event, Emitter<RecipeBookmarkState> emit) async{
    try{
      await _deleteAllBookmarks(params: 0);
      emit(state.copyWith(bookmarkedRecipes: [],status: BookmarkFirestoreStatus.success));
    }on Exception catch(e){
      emit(state.copyWith(status: BookmarkFirestoreStatus.failed,error: 'could not delete bookmarked recipes'));
    }
  }
}
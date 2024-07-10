import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/domain/usecases/get_bookmarked_recipes.dart';
import 'package:recipe_app/domain/usecases/get_next_page_recipes.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_event.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_state.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/utils/data_state.dart';
import '../../../domain/model/recipe.dart';
import '../../../domain/usecases/get_recipes.dart';

class RemoteRecipeBloc extends Bloc<RemoteRecipeEvent, RemoteRecipeState> {
  final GetRecipesUseCase _getRecipes;
  final GetNextPageRecipesUseCase _getNextPageRecipes;

  RemoteRecipeBloc(this._getRecipes, this._getNextPageRecipes) : super(const RemoteRecipeState()) {
    on<GetRecipesEvent>(onGetRecipes);
  }

  void onGetRecipes(
      GetRecipesEvent event, Emitter<RemoteRecipeState> emit) async {
    if (state.status == RecipeStatus.initial || (state.status == RecipeStatus.failure && state.recipeList.isEmpty)) {
      //initial fetch
      //emit(state.copyWith(query:event.query,filters:event.filters,status: RecipeStatus.searching));
      final dataState = await _getRecipes(params: {'query': event.query});
      if (dataState is DataSuccess) {
        var recipeList = dataState.data ?? [];
        emit(RemoteRecipeState(
            status: RecipeStatus.success,
            recipeList: recipeList, // Handle null data
            nextPage: dataState.nextPageUrl,
            query: event.query,
            filters: event.filters,
            hasReachedMax: (dataState.data?.isNotEmpty ?? false) && dataState.nextPageUrl == null)); // Handle null data
      } else {
        emit(state.copyWith(status: RecipeStatus.failure, error: dataState.error));
      }
    }

    if (state.query != event.query || !mapEquals(state.filters, event.filters)) {
      //searching by query and by filter
      final dataState = await _getRecipes(params: Map.of(event.filters)..['query'] = event.query);
      emit(RemoteRecipeState(
          status: RecipeStatus.searching,
          recipeList: state.recipeList,
          nextPage: state.nextPage,
          query: event.query,
          filters: event.filters,
          hasReachedMax: (dataState.data?.isNotEmpty ?? false) && dataState.nextPageUrl == null)); // Handle null data
      await Future.delayed(const Duration(seconds: 1));

      if (dataState is DataSuccess) {
        var recipeList = dataState.data ?? [];
        emit(RemoteRecipeState(
            status: RecipeStatus.success,
            recipeList: recipeList,
            nextPage: dataState.nextPageUrl,
            query: event.query,
            filters: event.filters,
            hasReachedMax: (dataState.data?.isNotEmpty ?? false) && dataState.nextPageUrl == null)); // Handle null data
      } else {
        emit(state.copyWith(status: RecipeStatus.failure, error: dataState.error));
      }
    }

    if (state.hasReachedMax) return;
    final dataState = await _getNextPageRecipes(params: state.nextPage!);
    if (dataState is DataSuccess) {
      //fetch next page(next 30 items) when scrolling
      var recipeList = dataState.data ?? [];
      emit(RemoteRecipeState(
          status: RecipeStatus.success,
          recipeList: List.of(state.recipeList)..addAll(recipeList), // Handle null data
          nextPage: dataState.nextPageUrl,
          query: event.query,
          filters: event.filters,
          hasReachedMax: (dataState.data?.isNotEmpty ?? false) && dataState.nextPageUrl == null)); // Handle null data
    } else {
      emit(state.copyWith(status: RecipeStatus.failure, error: dataState.error));
    }
  }
}

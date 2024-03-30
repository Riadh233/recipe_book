import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/domain/usecases/get_next_page_recipes.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_event.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_state.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/utils/data_state.dart';
import '../../../domain/usecases/get_recipes.dart';

class RemoteRecipeBloc extends Bloc<RemoteRecipeEvent, RemoteRecipeState> {
  final GetRecipesUseCase _getRecipesUseCase;
  final GetNextPageRecipesUseCase _getNextPageRecipesUseCase;

  RemoteRecipeBloc(this._getRecipesUseCase, this._getNextPageRecipesUseCase) : super(const RemoteRecipeState()) {
    on<GetRecipesEvent>(onGetRecipes);
  }

  void onGetRecipes(
      GetRecipesEvent event, Emitter<RemoteRecipeState> emit) async {
    logger.log(Logger.level, 'state query:${state.query} , event query:${event.query}');

    if (state.hasReachedMax) return;
    if (state.status == RecipeStatus.initial) {
      final dataState = await _getRecipesUseCase(params: {'query':event.query});
      if(dataState is DataSuccess){
        return emit(RemoteRecipeState(
            status: RecipeStatus.success,
            recipeList: dataState.data!,
            nextPage: dataState.nextPageUrl,
            query: event.query,
            filters: event.filters,
            hasReachedMax: false));
      }else{
        return emit(RemoteRecipeState(
            status: RecipeStatus.failure,
            recipeList: state.recipeList,
            error: dataState.error,
            hasReachedMax: false));
      }
    }
    if( state.query != event.query || !mapEquals(state.filters,event.filters)){
      final dataState = await _getRecipesUseCase(params: event.filters..['query'] = event.query);
      if(dataState is DataSuccess){
        logger.log(Logger.level, 'event filters:${event.filters}');
        emit(RemoteRecipeState(
            status: RecipeStatus.searching,
            recipeList: dataState.data!,
            nextPage: dataState.nextPageUrl,
            query: event.query,
            filters: event.filters,
            hasReachedMax: false));
      }else{
        emit(RemoteRecipeState(
            status: RecipeStatus.failure,
            recipeList: state.recipeList,
            error: dataState.error,
            hasReachedMax: false));
      }
    }

    final dataState = await _getNextPageRecipesUseCase(params: state.nextPage!);
    logger.log(Logger.level, 'next page are identical:${state.nextPage == dataState.nextPageUrl}');
      if (dataState is DataSuccess) {
        emit(RemoteRecipeState(
            status: RecipeStatus.success,
            recipeList: List.of(state.recipeList)..addAll(dataState.data!),
            nextPage: dataState.nextPageUrl,
            query: event.query,
            filters: event.filters,
            hasReachedMax: dataState.nextPageUrl == null));
      } else {
        emit(
            state.copyWith(status: RecipeStatus.failure, error: dataState.error));
      }
    }
}

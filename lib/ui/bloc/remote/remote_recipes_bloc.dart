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
    if (state.hasReachedMax) return;
    if (state.status == RecipeStatus.initial) {
      final dataState = await _getRecipesUseCase(params: {'query':'meat', 'diet': event.diet,
      'calories': event.calories});
      if(dataState is DataSuccess){
        return emit(RemoteRecipeState(
            status: RecipeStatus.success,
            recipeList: dataState.data!,
            nextPage: dataState.nextPageUrl,
            hasReachedMax: false));
      }else{
        return emit(RemoteRecipeState(
            status: RecipeStatus.failure,
            recipeList: state.recipeList,
            error: dataState.error,
            hasReachedMax: false));
      }
    }
    final dataState = await _getNextPageRecipesUseCase(params: state.nextPage!);
    logger.log(Logger.level, 'next page are identical:${state.nextPage == dataState.nextPageUrl}');
      if (dataState is DataSuccess) {
        logger.log(Logger.level,dataState.data!.length);
        emit(RemoteRecipeState(
            status: RecipeStatus.success,
            recipeList: List.of(state.recipeList)..addAll(dataState.data!),
            nextPage: dataState.nextPageUrl,
            hasReachedMax: dataState.nextPageUrl == null));
      } else {
        emit(
            state.copyWith(status: RecipeStatus.failure, error: dataState.error));
      }
    }
}

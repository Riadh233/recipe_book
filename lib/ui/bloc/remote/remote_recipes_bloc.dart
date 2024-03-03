import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_event.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_state.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/utils/data_state.dart';
import '../../../domain/usecases/get_recipes.dart';

class RemoteRecipeBloc extends Bloc<RemoteRecipeEvent, RemoteRecipeState> {
  final GetRecipesUseCase _getRecipesUseCase;

  RemoteRecipeBloc(this._getRecipesUseCase) : super(const RemoteRecipeState()) {
    on<GetRecipesEvent>(onGetRecipes);
  }

  void onGetRecipes(
      GetRecipesEvent event, Emitter<RemoteRecipeState> emit) async {
    logger.log(Logger.level,'recipe list size : ${state.recipeList.length}');
    if (state.hasReachedMax) return;
    if (state.status == RecipeStatus.initial) {
      final dataState = await _getRecipesUseCase(params: {'query':'meat'});
      if(dataState is DataSuccess){
        return emit(RemoteRecipeState(
            status: RecipeStatus.success,
            recipeList: dataState.data!,
            hasReachedMax: false));
      }else{
        logger.log(Logger.level,dataState.data?.length);
        return emit(RemoteRecipeState(
            status: RecipeStatus.failure,
            recipeList: state.recipeList,
            error: dataState.error,
            hasReachedMax: false));
      }
    }
    final dataState = await _getRecipesUseCase(params: {
      'query': event.query,
      'from': state.recipeList.length,
      'to': state.recipeList.length + 20,
      'diet': event.diet,
      'calories': event.calories
    });
    if (dataState is DataSuccess) {
      logger.log(Logger.level,dataState.data!.length);
      emit(dataState.data!.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : RemoteRecipeState(
              status: RecipeStatus.success,
              recipeList: List.of(state.recipeList)..addAll(dataState.data!),
              hasReachedMax: false));
    } else {
      emit(
          state.copyWith(status: RecipeStatus.failure, error: dataState.error));
    }
  }
}

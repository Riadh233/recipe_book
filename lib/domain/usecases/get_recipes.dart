import 'package:logger/logger.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/domain/usecases/usecase.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/utils/data_state.dart';
import 'package:recipe_app/utils/constants.dart';

import '../repository/recipe_repository.dart';

class GetRecipesUseCase
    implements UseCase<DataState<List<Recipe>>, Map<String, String>> {
  final RecipeRepository repository;

  GetRecipesUseCase({required this.repository});

  @override
  Future<DataState<List<Recipe>>> call({required Map<String, String> params}) {
    return repository.getRecipes(
        query: params['query'] ?? '',
        calories:params[CALORIES] ?? DEFAULT_FILTERS[CALORIES]!,
        diet:params[DIET_TYPE] ?? DEFAULT_FILTERS[DIET_TYPE]!,
        mealType:params[MEAL_TYPE] ?? DEFAULT_FILTERS[MEAL_TYPE]!,
        dishType: params[DISH_TYPE] ?? DEFAULT_FILTERS[DISH_TYPE]!,
        cuisineType: params[CUISINE_TYPE] ?? DEFAULT_FILTERS[CUISINE_TYPE]!,
        totalTime:params[TOTAL_TIME] ?? DEFAULT_FILTERS[TOTAL_TIME]!);
  }
}

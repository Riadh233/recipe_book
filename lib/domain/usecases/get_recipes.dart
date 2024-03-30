import 'package:logger/logger.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/domain/usecases/usecase.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/utils/data_state.dart';
import 'package:recipe_app/utils/constants.dart';

import '../repository/recipe_repository.dart';

class GetRecipesUseCase
    implements UseCase<DataState<List<Recipe>>, Map<String, dynamic>> {
  final RecipeRepository repository;

  GetRecipesUseCase({required this.repository});

  @override
  Future<DataState<List<Recipe>>> call({required Map<String, dynamic> params}) {
    return repository.getRecipes(
        query: params.containsKey('query') ? params['query'] : DEFAULT_QUERY,
        calories: params.containsKey(CALORIES) ? params[CALORIES] : '',
        diet: params.containsKey(DIET_TYPE) ? params[DIET_TYPE] : '',
        mealType: params.containsKey(MEAL_TYPE) ? params[MEAL_TYPE] : '',
        dishType: params.containsKey(DISH_TYPE) ? params[DISH_TYPE] : '',
        totalTime:params.containsKey(TOTAL_TIME) ? params[TOTAL_TIME] : '');
  }
}

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
    logger.log(Logger.level, params['from']);
    return repository.getRecipes(
        query: params.containsKey('query') ? params['query'] : DEFAULT_QUERY,
        from: params.containsKey('from') ? params['from'] : DEFAULT_FROM,
        to: params.containsKey('to') ? params['to'] : DEFAULT_TO,
        calories: params.containsKey('calories')
            ? params['calories']
            : DEFAULT_CALORIES,
        diet: params.containsKey('diet') ? params['diet'] : '',
        cuisineType:
            params.containsKey('cuisineType') ? params['cuisineType'] : '');
  }
}

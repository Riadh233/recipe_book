import 'package:recipe_app/domain/usecases/usecase.dart';

import '../../utils/data_state.dart';
import '../model/recipe.dart';
import '../repository/recipe_repository.dart';

class GetNextPageRecipesUseCase
    implements UseCase<DataState<List<Recipe>>,String> {
  final RecipeRepository repository;

  GetNextPageRecipesUseCase({required this.repository});

  @override
  Future<DataState<List<Recipe>>> call({required String params}) {
    return repository.getNextPageRecipes(nextPageUrl: params);
  }
}

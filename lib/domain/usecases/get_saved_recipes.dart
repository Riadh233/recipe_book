import 'package:recipe_app/domain/usecases/usecase.dart';
import '../model/recipe.dart';
import '../repository/recipe_repository.dart';

class GetSavedRecipesUseCase implements UseCase<List<Recipe>,void>{
  final RecipeRepository repository;

  GetSavedRecipesUseCase({required this.repository});

  @override
  Future<List<Recipe>> call({void params}) {
    return repository.getSavedRecipes();
  }
}
import '../../utils/data_state.dart';
import '../model/recipe.dart';

abstract class RecipeRepository {
  Future<DataState<List<Recipe>>> getRecipes({
    required String query,
    required String mealType,
    required String dishType,
    required String diet,
    required String calories,
    required String totalTime,
  });

  Future<DataState<List<Recipe>>> getNextPageRecipes(
      {required String? nextPageUrl});

  Future<void> saveRecipe(Recipe recipe);

  Future<void> deleteRecipe(Recipe recipe);

  Future<List<Recipe>> getSavedRecipes();
}

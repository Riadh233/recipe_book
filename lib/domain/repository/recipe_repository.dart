import '../../utils/data_state.dart';
import '../model/recipe.dart';

abstract class RecipeRepository {
  Future<DataState<List<Recipe>>> getRecipes(
      {required String query,
      required String calories,
      required String diet,
      required String cuisineType});
  Future<DataState<List<Recipe>>> getNextPageRecipes({required String? nextPageUrl});

  Future<void> saveRecipe(Recipe recipe);

  Future<void> deleteRecipe(Recipe recipe);

  Future<List<Recipe>> getSavedRecipes();
}

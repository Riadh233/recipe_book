import '../../utils/data_state.dart';
import '../model/recipe.dart';

abstract class RecipeRepository {
  Future<DataState<List<Recipe>>> getRecipes(
      {required String query,
      required int from,
      required int to,
      required String calories,
      required String diet,
      required String cuisineType});

  Future<void> saveRecipe(Recipe recipe);

  Future<void> deleteRecipe(Recipe recipe);

  Future<List<Recipe>> getSavedRecipes();
}

import '../model/recipe.dart';

abstract class CloudStoreRepository {
  Future<void> bookmarkRecipe(Recipe recipe);
  Future<void> unbookmarkRecipe(Recipe recipe);
  Future<List<Recipe>> getBookmarkedRecipes();
  Future<void> deleteAllBookmarkedRecipes();
  Future<bool> isRecipeBookmarked(Recipe recipe);
}
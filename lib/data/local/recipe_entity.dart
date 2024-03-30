import '../../data/remote/recipe_query_model.dart';
import '../../domain/model/recipe.dart';

class RecipeEntity {
  String? label;
  RecipeImage? image;
  String? url;
  List<String> cuisineType = [];
  List<String> dietLabels = [];
  List<String> mealType = [];
  List<String> ingredientLines = [];
  List<String> dishType = [];
  List<APIIngredients> ingredients = [];
  List<String> totalNutrients = [];
  double? calories;
  double? totalWeight;
  double? totalTime;

  RecipeEntity({
    required this.label,
    required this.image,
    required this.url,
    required this.ingredients,
    required this.calories,
    required this.totalWeight,
    required this.totalTime,
    required this.dietLabels,
    required this.mealType,
    required this.dishType,
    required this.totalNutrients,
    required this.ingredientLines,
  });

  factory RecipeEntity.fromRecipeDto(RecipeDto recipeDto){
    return RecipeEntity(
        label: recipeDto.label,
        image: recipeDto.image,
        url: recipeDto.url,
        ingredients: recipeDto.ingredients ?? [],
        calories: recipeDto.calories,
        totalWeight: recipeDto.totalWeight,
        totalTime: recipeDto.totalTime,
        dietLabels: recipeDto.dietLabels ?? [],
        mealType: recipeDto.mealType ?? [],
        dishType: recipeDto.dishType ?? [],
        totalNutrients: recipeDto.getNutrients(),
        ingredientLines: recipeDto.ingredientLines ?? []);
  }

  factory RecipeEntity.fromRecipe(Recipe recipe){
    return RecipeEntity(
        label:recipe.label,
        image: recipe.image,
        url: recipe.url,
        ingredients: recipe.ingredients,
        calories: recipe.calories,
        totalWeight: recipe.totalWeight,
        totalTime: recipe.totalTime,
        dietLabels: recipe.dietLabels,
        dishType: recipe.dishType,
        mealType: recipe.mealType,
        totalNutrients: recipe.totalNutrients,
        ingredientLines: recipe.ingredientLines
    );
  }
}
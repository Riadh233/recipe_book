import '../../data/remote/recipe_query_model.dart';
import '../../domain/model/recipe.dart';

class RecipeEntity {
  String? label;
  String? image;
  String? url;
  String? cuisineType;
  List<String>? dietLabels;
  List<String>? mealType;
  List<String>? ingredientLines;
  List<APIIngredients>? ingredients;
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
    required this.ingredientLines,
  });

  factory RecipeEntity.fromRecipeDto(RecipeDto recipeDto){
    return RecipeEntity(
        label: recipeDto.label,
        image: recipeDto.image,
        url: recipeDto.url,
        ingredients: recipeDto.ingredients,
        calories: recipeDto.calories,
        totalWeight: recipeDto.totalWeight,
        totalTime: recipeDto.totalTime,
        dietLabels: recipeDto.dietLabels,
        mealType: recipeDto.mealType,
        ingredientLines: recipeDto.ingredientLines);
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
        mealType: recipe.mealType,
        ingredientLines: recipe.ingredientLines
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/firestore/firestore_recipe.dart';
import '../../data/remote/recipe_query_model.dart';

class Recipe {
  String? label;
  RecipeImage? image;
  bool isBookmarked;
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

  Recipe({
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
    required this.ingredientLines,
    required this.totalNutrients,
    required this.cuisineType,
    this.isBookmarked = false,
  });

  factory Recipe.fromRecipeDto(RecipeDto recipeDto) {
    return Recipe(
      label: recipeDto.label,
      image: recipeDto.image,
      url: recipeDto.url,
      ingredients: recipeDto.ingredients ?? [],
      calories: recipeDto.calories,
      totalWeight: recipeDto.totalWeight,
      cuisineType: recipeDto.cuisineType ?? [],
      totalTime: recipeDto.totalTime,
      dietLabels: recipeDto.dietLabels ?? [],
      dishType: recipeDto.dishType ?? [],
      mealType: recipeDto.mealType ?? [],
      totalNutrients: recipeDto.getNutrients(),
      ingredientLines: recipeDto.ingredientLines ?? [],
    );
  }

  factory Recipe.fromFirestoreRecipe(FirestoreRecipe recipeEntity) {
    return Recipe(
      label: recipeEntity.label,
      image: recipeEntity.image,
      url: recipeEntity.url,
      ingredients: recipeEntity.ingredients,
      calories: recipeEntity.calories,
      totalWeight: recipeEntity.totalWeight,
      cuisineType: recipeEntity.cuisineType,
      totalTime: recipeEntity.totalTime,
      dietLabels: recipeEntity.dietLabels,
      dishType: recipeEntity.dishType,
      mealType: recipeEntity.mealType,
      totalNutrients: recipeEntity.totalNutrients,
      ingredientLines: recipeEntity.ingredientLines,
      isBookmarked: true,
    );
  }

  String getCalories() {
    return calories == null ? '0 Cal' : '${calories!.floor()} Cal';
  }

  String getWeight() {
    return totalWeight == null ? '0 g' : '${totalWeight!.floor()} g';
  }

  String getMealType() {
    final words = mealType[0].split('/');
    if (words.length > 1) return words[1];
    return words[0];
  }

  String? getTime() {
    if (totalTime == null || totalTime == 0) {
      return null;
    } else {
      int timeInMin = totalTime!.floor();
      if (timeInMin <= 60) return '$timeInMin min';
      int hours = timeInMin ~/ 60;
      int minutes = timeInMin % 60;
      return '$hours h $minutes min';
    }
  }
}

import '../../data/local/recipe_entity.dart';
import '../../data/remote/recipe_query_model.dart';

class Recipe {
  String? label;
  RecipeImage? image;
  String? url;
  List<String> cuisineType = [];
  List<String> dietLabels = [];
  List<String> mealType = [];
  List<String> ingredientLines = [];
  List<APIIngredients> ingredients = [];
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
    required this.ingredientLines,
    required this.cuisineType
  });

  factory Recipe.fromRecipeDto(RecipeDto recipeDto) {
    return Recipe(label: recipeDto.label,
        image: recipeDto.image,
        url: recipeDto.url,
        ingredients: recipeDto.ingredients,
        calories: recipeDto.calories,
        totalWeight: recipeDto.totalWeight,
        cuisineType:recipeDto.cuisineType,
        totalTime: recipeDto.totalTime,
        dietLabels: recipeDto.dietLabels,
        mealType: recipeDto.mealType,
        ingredientLines: recipeDto.ingredientLines);
  }

  factory Recipe.fromRecipeEntity(RecipeEntity recipeEntity) {
    return Recipe(label:recipeEntity.label,
        image: recipeEntity.image,
        url: recipeEntity.url,
        ingredients: recipeEntity.ingredients,
        calories: recipeEntity.calories,
        totalWeight: recipeEntity.totalWeight,
        cuisineType: recipeEntity.cuisineType,
        totalTime: recipeEntity.totalTime,
        dietLabels: recipeEntity.dietLabels,
        mealType: recipeEntity.mealType,
        ingredientLines: recipeEntity.ingredientLines);
  }

  String getCalories() {
    return calories == null ? '0 Cal' : '${calories!.floor()} Cal';
  }

  String getWeight() {
    return totalWeight == null ? '0 g' : '${totalWeight!.floor()} g';
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

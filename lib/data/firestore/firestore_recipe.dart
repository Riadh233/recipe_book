import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../remote/recipe_query_model.dart';
import '../../domain/model/recipe.dart';
part 'firestore_recipe.g.dart';

@JsonSerializable()
class FirestoreRecipe {
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

  FirestoreRecipe({
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

  factory FirestoreRecipe.fromRecipeDto(RecipeDto recipeDto){
    return FirestoreRecipe(
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

  factory FirestoreRecipe.fromRecipe(Recipe recipe){
    return FirestoreRecipe(
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

  factory FirestoreRecipe._fromJson(Map<String, dynamic> json) => _$FirestoreRecipeFromJson(json);

  Map<String, dynamic> _toJson() => _$FirestoreRecipeToJson(this);

  factory FirestoreRecipe.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      ) {
    final data = snapshot.data();
    return FirestoreRecipe._fromJson(data ?? {});
  }

  Map<String, dynamic> toFirestore() => _toJson();
}
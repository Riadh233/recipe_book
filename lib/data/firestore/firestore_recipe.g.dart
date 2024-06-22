// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirestoreRecipe _$FirestoreRecipeFromJson(Map<String, dynamic> json) =>
    FirestoreRecipe(
      label: json['label'] as String?,
      image: null,
      url: json['url'] as String?,
      ingredients: [],
      calories: (json['calories'] as num?)?.toDouble(),
      totalWeight: (json['totalWeight'] as num?)?.toDouble(),
      totalTime: (json['totalTime'] as num?)?.toDouble(),
      dietLabels: (json['dietLabels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      mealType:
          (json['mealType'] as List<dynamic>).map((e) => e as String).toList(),
      dishType:
          (json['dishType'] as List<dynamic>).map((e) => e as String).toList(),
      totalNutrients: (json['totalNutrients'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      ingredientLines: (json['ingredientLines'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    )..cuisineType =
        (json['cuisineType'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$FirestoreRecipeToJson(FirestoreRecipe instance) =>
    <String, dynamic>{
      'label': instance.label,
      'image': null,
      'url': instance.url,
      'cuisineType': instance.cuisineType,
      'dietLabels': instance.dietLabels,
      'mealType': instance.mealType,
      'ingredientLines': instance.ingredientLines,
      'dishType': instance.dishType,
      'ingredients': null,
      'totalNutrients': instance.totalNutrients,
      'calories': instance.calories,
      'totalWeight': instance.totalWeight,
      'totalTime': instance.totalTime,
    };

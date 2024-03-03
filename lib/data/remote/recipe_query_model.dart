import 'package:json_annotation/json_annotation.dart';

part 'recipe_query_model.g.dart';

@JsonSerializable()
class RecipeQueryModel {
  @JsonKey(name: 'q')
  String? query;
  int? from;
  int? to;
  int? count;
  List<ApiHits>? hits;
  @JsonKey(name: '_links')
  Links? links;

  RecipeQueryModel({
    required this.query,
    required this.from,
    required this.to,
    required this.count,
    required this.hits,
    required this.links,
  });

  factory RecipeQueryModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeQueryModelFromJson(json);

}
@JsonSerializable()
class Links {
  NextPageLink self;
  Links({required this.self});

  factory Links.fromJson(Map<String, dynamic> json) =>
      _$LinksFromJson(json);
}
@JsonSerializable()
class NextPageLink {
  @JsonKey(name: 'href')
  String nextPage;
  NextPageLink({required this.nextPage});

  factory NextPageLink.fromJson(Map<String, dynamic> json) =>
      _$NextPageLinkFromJson(json);
}
@JsonSerializable()
class ApiHits {
  @JsonKey(name: 'recipe')
  final RecipeDto recipeDto;

  ApiHits({required this.recipeDto});

  factory ApiHits.fromJson(Map<String, dynamic> json) =>
      _$ApiHitsFromJson(json);
}

@JsonSerializable()
class RecipeDto {
  String? label;
  String? image;
  String? url;
  List<String>? cuisineType;
  List<String>? dietLabels;
  List<String>? mealType;
  List<String>? ingredientLines;
  List<APIIngredients>? ingredients;
  double? calories;
  double? totalWeight;
  double? totalTime;

  RecipeDto({
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

  factory RecipeDto.fromJson(Map<String, dynamic> json) =>
      _$RecipeDtoFromJson(json);
}

@JsonSerializable()
class APIIngredients {
  @JsonKey(name: 'text')
  String? name;
  double? weight;

  APIIngredients({
    required this.name,
    required this.weight,
  });

  factory APIIngredients.fromJson(Map<String, dynamic> json) =>
      _$APIIngredientsFromJson(json);
}
//
// @JsonSerializable()
// class TotalNutrients {
//   final Nutrient ENERC_KCAL;
//   final Nutrient FAT;
//   final Nutrient PROCNT;
//   final Nutrient SUGAR;
//   factory TotalNutrients.fromJson(Map<String, dynamic> json) => _$TotalNutrientsFromJson(json);
//   Map<String, dynamic> toJson() => _$TotalNutrientsToJson(this);
//
//   TotalNutrients({required this.ENERC_KCAL, required this.FAT, required this.PROCNT, required this.SUGAR});
// }
// @JsonSerializable()
// class Nutrient{
//   final String label;
//   final double quantity;
//   final String unit;
//
//   Nutrient({required this.label, required this.quantity, required this.unit});
//
//   factory Nutrient.fromJson(Map<String, dynamic> json) => _$NutrientFromJson(json);
//   Map<String, dynamic> toJson() => _$NutrientToJson(this);
// }

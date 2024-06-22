import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_app/domain/model/recipe.dart';

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

  Map<String,dynamic> toJson() => _$RecipeQueryModelToJson(this);
}

@JsonSerializable()
class Links {
  NextPageLink? next;

  Links({required this.next});

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);
  Map<String,dynamic> toJson() => _$LinksToJson(this);

}

@JsonSerializable()
class NextPageLink {
  @JsonKey(name: 'href')
  String nextPage;

  NextPageLink({required this.nextPage});

  factory NextPageLink.fromJson(Map<String, dynamic> json) =>
      _$NextPageLinkFromJson(json);

  Map<String,dynamic> toJson() => _$NextPageLinkToJson(this);
}

@JsonSerializable()
class ApiHits {
  @JsonKey(name: 'recipe')
  final RecipeDto recipeDto;

  ApiHits({required this.recipeDto});

  factory ApiHits.fromJson(Map<String, dynamic> json) =>
      _$ApiHitsFromJson(json);

  Map<String,dynamic> toJson() => _$ApiHitsToJson(this);
}

@JsonSerializable()
class RecipeDto {
  String? label;
  @JsonKey(name: 'images')
  RecipeImage image;
  String? url;
  List<String>? cuisineType = [];
  List<String>? dietLabels = [];
  List<String>? mealType = [];
  List<String>? ingredientLines = [];
  List<String>? dishType = [];
  TotalNutrients totalNutrients;
  List<APIIngredients>? ingredients = [];
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
    required this.totalNutrients,
    required this.ingredientLines,
  });

  factory RecipeDto.fromJson(Map<String, dynamic> json) =>
      _$RecipeDtoFromJson(json);

  Map<String,dynamic> toJson() => _$RecipeDtoToJson(this);

  List<String> getNutrients() {
    return [
      '${totalNutrients.ENERC_KCAL.label}: ${totalNutrients.ENERC_KCAL.quantity.round()} ${totalNutrients.ENERC_KCAL.unit}',
      '${totalNutrients.CHOCDF.label}: ${totalNutrients.CHOCDF.quantity.round()} ${totalNutrients.CHOCDF.unit}',
      '${totalNutrients.FAT.label}: ${totalNutrients.FAT.quantity.round()} ${totalNutrients.FAT.unit}',
      '${totalNutrients.FIBTG.label}: ${totalNutrients.FIBTG.quantity.round()} ${totalNutrients.FIBTG.unit}',
      '${totalNutrients.PROCNT.label}: ${totalNutrients.PROCNT.quantity.round()} ${totalNutrients.PROCNT.unit}',
      '${totalNutrients.SUGAR.label}: ${totalNutrients.SUGAR.quantity.round()} ${totalNutrients.SUGAR.unit}',
    ];
  }
}

@JsonSerializable()
class RecipeImage {
  ApiImage THUMBNAIL;
  ApiImage SMALL;
  ApiImage REGULAR;

  RecipeImage(
      {required this.SMALL, required this.REGULAR, required this.THUMBNAIL});

  factory RecipeImage.fromJson(Map<String, dynamic> json) =>
      _$RecipeImageFromJson(json);

  Map<String,dynamic> toJson() => _$RecipeImageToJson(this);
}

@JsonSerializable()
class ApiImage {
  String url;

  ApiImage({required this.url});

  factory ApiImage.fromJson(Map<String, dynamic> json) =>
      _$ApiImageFromJson(json);

  Map<String,dynamic> toJson() => _$ApiImageToJson(this);
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

@JsonSerializable()
class TotalNutrients {
  final Nutrient ENERC_KCAL;
  final Nutrient CHOCDF;
  final Nutrient FAT;
  final Nutrient PROCNT;
  final Nutrient SUGAR;
  final Nutrient FIBTG;

  factory TotalNutrients.fromJson(Map<String, dynamic> json) =>
      _$TotalNutrientsFromJson(json);

  Map<String,dynamic> toJson() => _$TotalNutrientsToJson(this);

  TotalNutrients(
      {required this.ENERC_KCAL, required this.FAT, required this.PROCNT, required this.SUGAR, required this.FIBTG, required this.CHOCDF,});
}

@JsonSerializable()
class Nutrient {
  final String label;
  final double quantity;
  final String unit;

  Nutrient({required this.label, required this.quantity, required this.unit});

  factory Nutrient.fromJson(Map<String, dynamic> json) =>
      _$NutrientFromJson(json);

  Map<String,dynamic> toJson() => _$NutrientToJson(this);
}

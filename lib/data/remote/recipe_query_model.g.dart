// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_query_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeQueryModel _$RecipeQueryModelFromJson(Map<String, dynamic> json) =>
    RecipeQueryModel(
      query: json['q'] as String?,
      from: json['from'] as int?,
      to: json['to'] as int?,
      count: json['count'] as int?,
      hits: (json['hits'] as List<dynamic>?)
          ?.map((e) => ApiHits.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: json['_links'] == null
          ? null
          : Links.fromJson(json['_links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipeQueryModelToJson(RecipeQueryModel instance) =>
    <String, dynamic>{
      'q': instance.query,
      'from': instance.from,
      'to': instance.to,
      'count': instance.count,
      'hits': instance.hits,
      '_links': instance.links,
    };

Links _$LinksFromJson(Map<String, dynamic> json) => Links(
      next: NextPageLink.fromJson(json['next'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LinksToJson(Links instance) => <String, dynamic>{
      'next': instance.next,
    };

NextPageLink _$NextPageLinkFromJson(Map<String, dynamic> json) => NextPageLink(
      nextPage: json['href'] as String,
    );

Map<String, dynamic> _$NextPageLinkToJson(NextPageLink instance) =>
    <String, dynamic>{
      'href': instance.nextPage,
    };

ApiHits _$ApiHitsFromJson(Map<String, dynamic> json) => ApiHits(
      recipeDto: RecipeDto.fromJson(json['recipe'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiHitsToJson(ApiHits instance) => <String, dynamic>{
      'recipe': instance.recipeDto,
    };

RecipeDto _$RecipeDtoFromJson(Map<String, dynamic> json) => RecipeDto(
      label: json['label'] as String?,
      image: RecipeImage.fromJson(json['images'] as Map<String, dynamic>),
      url: json['url'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => APIIngredients.fromJson(e as Map<String, dynamic>))
          .toList(),
      calories: (json['calories'] as num?)?.toDouble(),
      totalWeight: (json['totalWeight'] as num?)?.toDouble(),
      totalTime: (json['totalTime'] as num?)?.toDouble(),
      dietLabels: (json['dietLabels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      mealType:
          (json['mealType'] as List<dynamic>).map((e) => e as String).toList(),
      ingredientLines: (json['ingredientLines'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    )..cuisineType =
        (json['cuisineType'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$RecipeDtoToJson(RecipeDto instance) => <String, dynamic>{
      'label': instance.label,
      'images': instance.image,
      'url': instance.url,
      'cuisineType': instance.cuisineType,
      'dietLabels': instance.dietLabels,
      'mealType': instance.mealType,
      'ingredientLines': instance.ingredientLines,
      'ingredients': instance.ingredients,
      'calories': instance.calories,
      'totalWeight': instance.totalWeight,
      'totalTime': instance.totalTime,
    };

RecipeImage _$RecipeImageFromJson(Map<String, dynamic> json) => RecipeImage(
      SMALL: ApiImage.fromJson(json['SMALL'] as Map<String, dynamic>),
      REGULAR: ApiImage.fromJson(json['REGULAR'] as Map<String, dynamic>),
      THUMBNAIL: ApiImage.fromJson(json['THUMBNAIL'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RecipeImageToJson(RecipeImage instance) =>
    <String, dynamic>{
      'THUMBNAIL': instance.THUMBNAIL,
      'SMALL': instance.SMALL,
      'REGULAR': instance.REGULAR,
    };

ApiImage _$ApiImageFromJson(Map<String, dynamic> json) => ApiImage(
      url: json['url'] as String,
    );

Map<String, dynamic> _$ApiImageToJson(ApiImage instance) => <String, dynamic>{
      'url': instance.url,
    };

APIIngredients _$APIIngredientsFromJson(Map<String, dynamic> json) =>
    APIIngredients(
      name: json['text'] as String?,
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$APIIngredientsToJson(APIIngredients instance) =>
    <String, dynamic>{
      'text': instance.name,
      'weight': instance.weight,
    };

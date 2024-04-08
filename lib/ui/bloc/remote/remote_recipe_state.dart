import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_app/utils/constants.dart';

import '../../../domain/model/recipe.dart';

enum RecipeStatus { initial, success, failure,searching }

class RemoteRecipeState extends Equatable {
  final List<Recipe> recipeList;
  final RecipeStatus status;
  final String? nextPage;
  final bool hasReachedMax;
  final String query;
  final Map<String,String> filters;
  final DioException? error;

  const RemoteRecipeState({
    this.status = RecipeStatus.initial,
    this.recipeList = const <Recipe>[],
    this.nextPage,
    this.hasReachedMax = false,
    this.query = '',
    this.filters = DEFAULT_FILTERS,
    this.error
  });

  RemoteRecipeState copyWith(
      {RecipeStatus? status, List<Recipe>? recipeList, bool? hasReachedMax,String? nextPage,DioException? error}){
    return RemoteRecipeState(
      status: status ?? this.status,
      recipeList: recipeList ?? this.recipeList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      nextPage: nextPage ?? this.nextPage,
      error: error ?? this.error
    );
  }
  @override
  String toString() {
    return '''RemoteRecipeState{status:$status, hasReachedMax:$hasReachedMax, recipeList:${recipeList.length} , nextPageLink:$nextPage}''';
  }
  @override
  List<Object?> get props => [recipeList, status, hasReachedMax,nextPage,error,query,filters];
}
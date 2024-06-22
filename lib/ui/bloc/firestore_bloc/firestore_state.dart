import 'package:equatable/equatable.dart';

import '../../../domain/model/recipe.dart';

enum BookmarkStatus { initial, success, failed }

class RecipeBookmarkState extends Equatable {
  final List<Recipe> bookmarkedRecipes;
  final BookmarkStatus status;
  final String? error;

  RecipeBookmarkState(this.bookmarkedRecipes, this.status, this.error);

  RecipeBookmarkState copyWith({List<Recipe>? bookmarkedRecipes,BookmarkStatus? status,String? error}){
    return RecipeBookmarkState(bookmarkedRecipes ?? this.bookmarkedRecipes, status ?? this.status, error ?? this.error);
  }

  @override
  List<Object?> get props => [bookmarkedRecipes, status, error];
}
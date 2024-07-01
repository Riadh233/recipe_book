import 'package:equatable/equatable.dart';

import '../../../domain/model/recipe.dart';

enum BookmarkFirestoreStatus { initial, success, failed }

class RecipeBookmarkState extends Equatable {
  final List<Recipe> bookmarkedRecipes;
  final BookmarkFirestoreStatus status;
  final String? error;

  const RecipeBookmarkState(this.bookmarkedRecipes, this.status, this.error);

  RecipeBookmarkState copyWith({List<Recipe>? bookmarkedRecipes,BookmarkFirestoreStatus? status,String? error}){
    return RecipeBookmarkState(bookmarkedRecipes ?? this.bookmarkedRecipes, status ?? this.status, error ?? this.error);
  }

  @override
  List<Object?> get props => [bookmarkedRecipes, status, error];
}
import '../../../domain/model/recipe.dart';

abstract class FirestoreEvent {
  const FirestoreEvent();
}

class BookmarkRecipeEvent extends FirestoreEvent{
  final Recipe recipe;
  BookmarkRecipeEvent(this.recipe);
}
class GetBookmarkedRecipesEvent extends FirestoreEvent{
  GetBookmarkedRecipesEvent();
}
class UnbookmarkRecipeEvent extends FirestoreEvent{
  final Recipe recipe;

  UnbookmarkRecipeEvent({required this.recipe});
}
class DeleteAllBookmarksEvent extends FirestoreEvent{
  const DeleteAllBookmarksEvent();
}
class AppStartedEvent extends FirestoreEvent{
  const AppStartedEvent();
}


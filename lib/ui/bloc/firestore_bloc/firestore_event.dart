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
class AppStartedEvent extends FirestoreEvent{
  const AppStartedEvent();
}

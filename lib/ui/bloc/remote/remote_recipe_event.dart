abstract class RemoteRecipeEvent{
   const RemoteRecipeEvent();
}

class GetRecipesEvent extends RemoteRecipeEvent{
  final String query;
  final String calories;
  final String diet;

  const GetRecipesEvent(
      {required this.query, required this.calories, required this.diet}) : super();
}
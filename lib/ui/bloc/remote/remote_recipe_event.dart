abstract class RemoteRecipeEvent{
   const RemoteRecipeEvent();
}

class GetRecipesEvent extends RemoteRecipeEvent{
  final String query;
  final Map<String,dynamic> filters;

  const GetRecipesEvent(
      {required this.filters,required this.query}) : super();
}
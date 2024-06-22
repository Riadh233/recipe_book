import 'package:recipe_app/domain/usecases/usecase.dart';

import '../model/recipe.dart';
import '../repository/cloud_store_repository.dart';

class GetBookmarkedRecipesUseCase implements UseCase<List<Recipe>,int>{
  final CloudStoreRepository repository;

  GetBookmarkedRecipesUseCase({required this.repository});

  @override
  Future<List<Recipe>> call({required int params}) async{
   return await repository.getBookmarkedRecipes();
  }

}
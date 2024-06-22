import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/domain/repository/cloud_store_repository.dart';
import 'package:recipe_app/domain/usecases/usecase.dart';

class BookmarkRecipeUseCase implements UseCase<void,Recipe>{
  final CloudStoreRepository repository;

  BookmarkRecipeUseCase({required this.repository});
  @override
  Future<void> call({required Recipe params}) async {
    repository.bookmarkRecipe(params);
  }
}
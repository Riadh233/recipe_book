import 'package:recipe_app/data/repository/cloud_store_repository_impl.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/domain/usecases/usecase.dart';

import '../repository/cloud_store_repository.dart';

class IsRecipeBookmarkedUseCase implements UseCase<bool,Recipe>{
  CloudStoreRepository repository;

  IsRecipeBookmarkedUseCase({required this.repository});

  @override
  Future<bool> call({required Recipe params}) async {
    return await repository.isRecipeBookmarked(params);
  }
}
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/domain/usecases/usecase.dart';

import '../repository/recipe_repository.dart';

class SaveRecipeUseCase implements UseCase<void,Recipe>{
  final RecipeRepository repository;

  SaveRecipeUseCase({required this.repository});

  @override
  Future<void> call({required Recipe params}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
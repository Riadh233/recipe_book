import 'package:recipe_app/domain/repository/recipe_repository.dart';
import 'package:recipe_app/domain/usecases/usecase.dart';

class SaveThemeUseCase implements UseCase<void,bool>{
 final RecipeRepository recipeRepository;

  SaveThemeUseCase({required this.recipeRepository});

  @override
  Future<void> call({required bool params}) async {
    await recipeRepository.saveAppTheme(params);
  }
}
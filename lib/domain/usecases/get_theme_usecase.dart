import 'package:recipe_app/domain/repository/recipe_repository.dart';
import 'package:recipe_app/domain/usecases/usecase.dart';

class GetThemeUseCase implements UseCase<bool,bool>{
  final RecipeRepository recipeRepository;

  GetThemeUseCase({required this.recipeRepository});

  @override
  Future<bool> call({required void params}) async {
    return await recipeRepository.getAppTheme();
  }
}
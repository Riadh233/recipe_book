import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/data/remote/recipe_api_service.dart';
import 'package:recipe_app/data/repository/recipe_repository_impl.dart';
import 'package:recipe_app/domain/usecases/get_next_page_recipes.dart';
import 'package:recipe_app/domain/usecases/get_recipes.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipes_bloc.dart';

import '../data/local/database_service.dart';
import '../domain/repository/recipe_repository.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerSingleton<DatabaseService>(DatabaseService());
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<RecipeApiService>(RecipeApiService(getIt()));
  getIt.registerSingleton<RecipeRepository>(RecipeRepositoryImpl(recipeService: getIt(), databaseService: getIt()));
  getIt.registerSingleton<GetRecipesUseCase>(GetRecipesUseCase(repository: getIt()));
  getIt.registerSingleton<GetNextPageRecipesUseCase>(GetNextPageRecipesUseCase(repository: getIt()));
  getIt.registerFactory(() => RemoteRecipeBloc(getIt(),getIt()));
}

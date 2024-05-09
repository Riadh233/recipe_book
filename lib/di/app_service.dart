import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_app/data/remote/recipe_api_service.dart';
import 'package:recipe_app/data/repository/auth_repository_impl.dart';
import 'package:recipe_app/data/repository/recipe_repository_impl.dart';
import 'package:recipe_app/domain/repository/auth_repository.dart';
import 'package:recipe_app/domain/usecases/get_next_page_recipes.dart';
import 'package:recipe_app/domain/usecases/get_recipes.dart';
import 'package:recipe_app/ui/bloc/auth_bloc/athentication_bloc.dart';
import 'package:recipe_app/ui/bloc/auth_bloc/authentication_event.dart';
import 'package:recipe_app/ui/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/recipe_filter_bloc.dart';
import 'package:recipe_app/ui/bloc/login_cubit/login_cubit.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipes_bloc.dart';
import 'package:recipe_app/ui/bloc/signup_cubit/signup_cubit.dart';

import '../data/local/database_service.dart';
import '../domain/repository/recipe_repository.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerSingleton<DatabaseService>(DatabaseService());
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton<RecipeApiService>(RecipeApiService(getIt()));
  getIt.registerSingleton<RecipeRepository>(RecipeRepositoryImpl(recipeService: getIt(), databaseService: getIt()));
  getIt.registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImpl(cache: getIt()));
  getIt.registerSingleton<GetRecipesUseCase>(GetRecipesUseCase(repository: getIt()));
  getIt.registerSingleton<GetNextPageRecipesUseCase>(GetNextPageRecipesUseCase(repository: getIt()));
  getIt.registerFactory<RemoteRecipeBloc>(() => RemoteRecipeBloc(getIt(),getIt()));
  getIt.registerFactory<FilterCubit>(() => FilterCubit());
  getIt.registerFactory<AuthenticationBloc>(() => AuthenticationBloc(authenticationRepository:getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt()));
  getIt.registerFactory<BottomNavCubit>(() => BottomNavCubit());
}

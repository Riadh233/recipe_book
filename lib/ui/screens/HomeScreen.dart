import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipes_bloc.dart';
import 'package:recipe_app/ui/widgets/recipes_list.dart';

import '../../di/app_service.dart';
import '../../utils/constants.dart';
import '../bloc/remote/remote_recipe_event.dart';

final logger = Logger();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<RemoteRecipeBloc>(
      create: (context) => getIt()
        ..add(const GetRecipesEvent(
          query: DEFAULT_QUERY,
          calories: DEFAULT_CALORIES,
          diet: DEFAULT_DIET,
        )),
      child: const RecipesList(),
    ));
  }

  // buildBody() {
  //   return BlocBuilder<RemoteRecipeBloc, RemoteRecipeState>(
  //       builder: (BuildContext context, state) {
  //     if (state.status == RecipeStatus.initial) {
  //       return const Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     }
  //     if (state.status == RecipeStatus.success) {
  //       return ListView.builder(
  //           itemCount: state.recipeList!.length,
  //           itemBuilder: (_, index) {
  //             final recipe = state.recipeList![index];
  //             return Text(recipe.label!);
  //           });
  //     } else {
  //       return Center(
  //           child: Text(
  //         state.error!.message!,
  //       ));
  //     }
  //   });
  // }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_event.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_state.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipes_bloc.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/utils/constants.dart';

import 'RecipeItem.dart';
import 'bottom_loader.dart';

class RecipesList extends StatefulWidget {
  const RecipesList({super.key});

  @override
  State<StatefulWidget> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    if (currentScroll >= (maxScroll * 0.9)) {
      context.read<RemoteRecipeBloc>().add(const GetRecipesEvent(
          query: DEFAULT_QUERY,
          diet: DEFAULT_DIET,
          calories: DEFAULT_CALORIES));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteRecipeBloc, RemoteRecipeState>(
        builder: (context, state) {
          if (state.status == RecipeStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == RecipeStatus.success) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (_, index) {
                return index >= state.recipeList.length
                    ? const BottomLoader()
                    : RecipeItem(
                  recipe: state.recipeList[index], onItemTaped: (item) {},);
              },
              itemCount: state.hasReachedMax
                  ? state.recipeList.length
                  : state.recipeList.length + 1,
              controller: _scrollController,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent:300,
                crossAxisSpacing: 10
              ),
            );
          } else {
            return Center(
                child: Text(
                  state.error != null ? state.error!.message! : "fetch failed"
                ));
          }
        });
  }
}

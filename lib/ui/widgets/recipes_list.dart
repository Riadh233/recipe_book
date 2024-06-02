import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_event.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_state.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipes_bloc.dart';
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
    if (currentScroll >= (maxScroll)) {
      context.read<RemoteRecipeBloc>().add(GetRecipesEvent(
          query: context.read<RemoteRecipeBloc>().state.query,
          filters: context.read<RemoteRecipeBloc>().state.filters));
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
        if(state.recipeList.isEmpty){
          return const Center(
            child: Text("no recipes found"),
          );
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (_, index) {
            return index >= state.recipeList.length
                ? const BottomLoader()
                : RecipeItem(
                    recipe: state.recipeList[index],
                  );
          },
          itemCount: state.hasReachedMax
              ? state.recipeList.length
              : state.recipeList.length + 1,
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 300, crossAxisSpacing: 10),
        );
      }
      if (state.status == RecipeStatus.searching) {
        //_scrollController.jumpTo(0.0);
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Center(
            child: Text(
                state.error != null ? state.error!.message! : "fetch failed"));
      }
    });
  }
}

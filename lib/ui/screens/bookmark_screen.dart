import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/bookmark_cubit/bookmark_cubit.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_bloc.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_event.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_state.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/utils/app_routes.dart';

import '../../domain/model/recipe.dart';

class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    context.read<FirestoreBloc>().add(GetBookmarkedRecipesEvent());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Bookmarks', style: theme.textTheme.headlineSmall),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz_outlined),
              onSelected: (value) {
                if(value == 'delete all bookmarks'){
                  context.read<FirestoreBloc>().add(const DeleteAllBookmarksEvent());
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'delete all bookmarks',
                      child: Text('Delete all bookmarks'))
                ];
              })
        ],
      ),
      body: Center(
        child: BlocBuilder<FirestoreBloc, RecipeBookmarkState>(
          builder: (context, state) {
            if (state.status == BookmarkFirestoreStatus.initial) {
              return const CircularProgressIndicator();
            }
            if (state.status == BookmarkFirestoreStatus.success) {
              if (state.bookmarkedRecipes.isEmpty) {
                return Container(
                  child: const Text('no bookmarks added'),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: state.bookmarkedRecipes.length,
                            itemBuilder: (context, index) {
                              return BookmarkedRecipeItem(
                                  recipe: state.bookmarkedRecipes[index]);
                            }))
                  ],
                );
              }
            } else {
              return const Text('cannot retrieve bookmarked items');
            }
          },
        ),
      ),
    );
  }
}

class BookmarkedRecipeItem extends StatelessWidget {
  final Recipe recipe;

  const BookmarkedRecipeItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    logger.log(Logger.level, recipe.cuisineType);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: (){
          context.pushNamed(AppRoutes.Details,extra: recipe);
          context.read<BookmarkCubit>().isRecipeBookmarked(recipe);
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: recipe.image?.THUMBNAIL.url ?? '',
                    fit: BoxFit.fill,
                    height: 80,
                    width: 80,
                  ),
                ),
                const SizedBox(width: 10),
                // Title and Description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.label ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        recipe.cuisineType.isNotEmpty ? recipe.cuisineType[0] : '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    //bookmark the recipe
                    context
                        .read<FirestoreBloc>()
                        .add(UnbookmarkRecipeEvent(recipe: recipe));
                  },
                  child: const Icon(
                    Icons.close,
                    size: 25,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

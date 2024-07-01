import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/bookmark_cubit/bookmark_cubit.dart';
import 'package:recipe_app/ui/bloc/bookmark_cubit/bookmark_state.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_bloc.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_event.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/model/recipe.dart';
import '../bloc/firestore_bloc/firestore_state.dart';

class DetailScreen extends StatelessWidget {
  final Recipe? recipe;

  const DetailScreen(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        color: theme.colorScheme.background,
        child: Stack(
          children: [
            CachedNetworkImage(
                imageUrl: recipe?.image?.REGULAR.url ?? '',
                placeholder: (conext, _) => Image.asset(
                      'assets/images/pizza_w700.png',
                      height: 200,
                      width: 200,
                    ),
                height: 300,
                width: double.infinity,
                fit: BoxFit.fill),
            GestureDetector(
              onTap: () {
                context.pop();
              },
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.amberAccent,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: GestureDetector(
                onTap: () async {
                  Share.shareUri(Uri.parse(recipe!.url!));
                },
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.amberAccent,
                  child: Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            RecipeDetailsDraggableSheet(recipe: recipe)
          ],
        ),
      ),
    );
  }
}

class RecipeDetailsDraggableSheet extends StatefulWidget {
  final Recipe? recipe;

  const RecipeDetailsDraggableSheet({required this.recipe, super.key});

  @override
  State<StatefulWidget> createState() => _RecipeDetailsDraggableSheetState();
}

class _RecipeDetailsDraggableSheetState
    extends State<RecipeDetailsDraggableSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
        minChildSize: 0.6,
        maxChildSize: 1,
        initialChildSize: 0.6,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(28.0),
                    topRight: Radius.circular(28.0)),
                color: theme.colorScheme.background
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 5,
                            width: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                  maxWidth: 270, minHeight: 60),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Material(
                                    child: Text(
                                        widget.recipe?.label ??
                                            'Crepes with Oranges and Ice',
                                        maxLines: null,
                                        style: theme.textTheme.headlineMedium),
                                  ),
                                  Material(
                                    child: Text(
                                      widget.recipe?.cuisineType[0] ??
                                          'Western',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: GoogleFonts.outfit(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 5.0,
                              right: 5.0,
                              child: BlocBuilder<BookmarkCubit, BookmarkState>(
                                  builder: (context, state) {
                                if (state.status == BookmarkStatus.initial) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      //bookmark the recipe
                                      logger.log(Logger.level,
                                          'from details .................:${state.isBookmarked}');
                                      if (state.isBookmarked) {
                                        context.read<FirestoreBloc>().add(
                                            UnbookmarkRecipeEvent(
                                                recipe: widget.recipe!));
                                        context
                                            .read<BookmarkCubit>()
                                            .unbookmarked();
                                      } else {
                                        context.read<FirestoreBloc>().add(
                                            BookmarkRecipeEvent(
                                                widget.recipe!));
                                        context
                                            .read<BookmarkCubit>()
                                            .bookmarked();
                                      }
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.amberAccent),
                                        child: Icon(
                                          state.isBookmarked
                                              ? Icons.bookmark
                                              : Icons.bookmark_outline,
                                          size: 40,
                                        )),
                                  );
                                }
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (widget.recipe?.getTime() != null)
                            buildCustomContainer(
                                Icons.access_time, widget.recipe!.getTime()!,theme),
                          buildCustomContainer(
                              Icons.local_fire_department_outlined,
                              widget.recipe!.getCalories(),theme),
                          buildCustomContainer(Icons.line_weight_outlined,
                              widget.recipe!.getWeight(),theme),
                          buildCustomContainer(Icons.fastfood_outlined,
                              widget.recipe!.getMealType(),theme),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Material(
                        child: Text('Ingredients',
                            style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      for (String ingredient in widget.recipe!.ingredientLines)
                        customRow(ingredient,theme),
                      const SizedBox(
                        height: 15,
                      ),
                      Material(
                        child: Text('Nutrients',
                            style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      for (String nutrient in widget.recipe!.totalNutrients)
                        customRow(nutrient,theme)
                    ],
                  ),
                ),
              ));
        });
  }

  Widget buildCustomContainer(IconData icon, String text,ThemeData theme) {
    return Container(
      height: 120,
      width: 80,
      decoration: const BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(50), bottom: Radius.circular(50))),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: theme.colorScheme.background,
              radius: 30,
              child: Icon(
                icon,
                color: theme.colorScheme.onBackground,
                size: 35,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Material(
                color: Colors.amberAccent,
                child: Text(
                  text,
                  maxLines: 2,
                  style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customRow(String ingredient,ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: CircleAvatar(
              radius: 5,
              backgroundColor: Colors.amber,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Material(
              child: Text(
                ingredient,
                style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: theme.colorScheme.onBackground),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

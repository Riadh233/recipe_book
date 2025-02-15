import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/utils/app_routes.dart';

import '../bloc/bookmark_cubit/bookmark_cubit.dart';

class RecipeItem extends StatelessWidget {
  final Recipe recipe;

  const RecipeItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            context.read<BookmarkCubit>().isRecipeBookmarked(recipe);
            context.pushNamed(AppRoutes.Details, extra: recipe);
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: recipe.image!.SMALL.url,
                      fit: BoxFit.fitHeight,
                      height: 220,
                    )),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: recipe.getTime() != null
                      ? IntrinsicWidth(
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                    child: Text(recipe.getTime()!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                ),
                // Positioned(
                //   bottom: 8.0,
                //   right: 8.0,
                //   child: GestureDetector(
                //     onTap: () {
                //       //bookmark the recipe
                //       // if clicked again call delete
                //     },
                //     child: Container(
                //         padding: const EdgeInsets.all(4),
                //         decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             color: Colors.black.withOpacity(0.5)),
                //         child: const Icon(
                //          Icons.bookmark_outline,
                //           color: Colors.white,
                //           size: 25,
                //         )),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          recipe.label!,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          recipe.cuisineType.isNotEmpty ? recipe.cuisineType[0] : '',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: GoogleFonts.lato(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}

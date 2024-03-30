import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/utils/app_routes.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/model/recipe.dart';

class DetailScreen extends StatelessWidget {
  final Recipe? recipe;

  const DetailScreen(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
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
              onTap: (){
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
                  onTap: () async{
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
    return DraggableScrollableSheet(
        minChildSize: 0.6,
        maxChildSize: 1,
        initialChildSize: 0.6,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.0),
                    topRight: Radius.circular(28.0)),
                color: Colors.white,
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
                                        style: GoogleFonts.outfit(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
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
                              child: GestureDetector(
                                onTap: () {
                                  //bookmark the recipe
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.amberAccent),
                                    child: const Icon(
                                      Icons.bookmark_border,
                                      color: Colors.black,
                                      size: 40,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if( widget.recipe?.getTime() != null)
                          buildCustomContainer(Icons.access_time, widget.recipe!.getTime()!),
                          buildCustomContainer(Icons.local_fire_department_outlined, widget.recipe!.getCalories()),
                          buildCustomContainer(Icons.line_weight_outlined, widget.recipe!.getWeight()),
                          buildCustomContainer(Icons.fastfood_outlined, widget.recipe!.getDishType()),
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Material(
                        child: Text(
                            'Ingredients',
                            style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      for(String ingredient in widget.recipe!.ingredientLines)
                        customRow(ingredient)
                      ,
                      const SizedBox(height: 15,),
                      Material(
                        child: Text(
                            'Nutrients',
                            style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      for(String nutrient in widget.recipe!.totalNutrients)
                        customRow(nutrient)
                    ],
                  ),
                ),
              ));
        });
  }
 Widget buildCustomContainer(IconData icon,String text ){
    return Container(
      height: 120,
      width: 80,
      decoration: const BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
              bottom: Radius.circular(50))),
      child: Padding(
        padding: const EdgeInsets.only(top:4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              child: Icon(
                icon,
                color: Colors.black,
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
                      fontSize: 13, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget customRow(String ingredient){
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
          const SizedBox(width: 5,),
          Expanded(
            child: Material(
              child: Text(
                ingredient,
                style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 13, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

}

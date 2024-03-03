import 'package:flutter/cupertino.dart';

import '../../domain/model/recipe.dart';

class DetailScreen extends StatelessWidget{
  final Recipe recipe;
  final void  Function(Recipe recipe) onRecipeClicked;

  const DetailScreen({super.key, required this.recipe, required this.onRecipeClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Details Screen"),
    );
  }
}
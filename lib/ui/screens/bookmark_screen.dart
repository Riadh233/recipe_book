import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_bloc.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_state.dart';

class BookmarkScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirestoreBloc,RecipeBookmarkState>(
      builder: (context,state) {
        return Scaffold(
          body: Center(
            child: ListView.builder(
              itemCount: state.bookmarkedRecipes.length,
                itemBuilder: (context,index){
              return Text(state.bookmarkedRecipes[index].label ?? '');
            }),
          ),
        );
      }
    );
  }
}
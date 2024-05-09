import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc/athentication_bloc.dart';
import '../bloc/auth_bloc/authentication_event.dart';
import '../widgets/CategoryChips.dart';
import '../widgets/recipes_list.dart';
import '../widgets/search_bar.dart';

class DiscoverRecipesScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          IconButton(onPressed: (){
            context.read<AuthenticationBloc>().add(const AppLogoutRequested());
          }, icon: const Icon(Icons.logout)),
          //const HomeHeader(),
          const SizedBox(
            height: 10,
          ),
          RecipeSearchBar(),
          const CategoryChips(),
          const Expanded(child: RecipesList()),
        ],
      ),
    );
  }
}
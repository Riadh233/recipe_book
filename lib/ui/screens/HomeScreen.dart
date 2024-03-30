import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/recipe_filter_bloc.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipes_bloc.dart';
import 'package:recipe_app/ui/widgets/recipes_list.dart';

import '../../di/app_service.dart';
import '../../utils/constants.dart';
import '../bloc/remote/remote_recipe_event.dart';
import '../widgets/search_bar.dart';

final logger = Logger();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              RecipeSearchBar(),
              const Expanded(child: RecipesList()),
            ],
          ),
        ),
      ),
    );
  }
}

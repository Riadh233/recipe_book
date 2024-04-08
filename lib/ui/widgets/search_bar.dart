import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/recipe_filter_bloc.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_event.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipes_bloc.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/ui/widgets/recipe_filter.dart';

import '../../utils/constants.dart';

class RecipeSearchBar extends StatelessWidget {
  final SearchController controller = SearchController();
  final FocusNode focusNode = FocusNode();
  RecipeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 50,
        child: SearchAnchor(
          searchController: controller,
          builder: (BuildContext anchorContext, _) {
            return SearchBar(
              focusNode: focusNode,
              padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0)),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
              hintText: 'Search any recipe',
              controller: controller,
              onTap: () {
                controller.openView();
              },
              onChanged: (query) {
                controller.openView();
              },
              leading: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              trailing: <Widget>[
                IconButton(
                    splashColor: Colors.grey[200],
                    color: Colors.white,
                    onPressed: () {
                      //open bottom sheet
                      openBottomSheet(context);
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 13.0,
                      minimumSize: const Size(30, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            14.0),
                      ),
                    ),
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.black,
                    ))
              ],
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
            );
          },
          suggestionsBuilder: (BuildContext context, controller) {
            return List<ListTile>.generate(
                SUGGESTION_QUERIES.length,
                    (index) =>
                    ListTile(
                      title: Text(SUGGESTION_QUERIES[index]),
                      onTap: () {
                        controller.closeView(SUGGESTION_QUERIES[index]);
                        context.read<RemoteRecipeBloc>()
                            .add(GetRecipesEvent(
                            filters: context
                                .read<FilterCubit>()
                                .state
                                .filtersMap, query: SUGGESTION_QUERIES[index]));
                        focusNode.unfocus();
                      },
                    ));
          },
          viewOnSubmitted: (query) {
            if (query.isNotEmpty) {
              context.read<RemoteRecipeBloc>()
                  .add(GetRecipesEvent(
                  filters: context
                      .read<FilterCubit>()
                      .state
                      .filtersMap, query: query));
              controller.closeView(query);
              focusNode.unfocus();
            }
          },
        ),
      ),
    );
  }
  Future<void> openBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Stack(
            children: [
              const RecipeFilter(),
              Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<FilterCubit>()
                              .resetFilters();
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          elevation: 8.0,
                          minimumSize: const Size(130, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0), // Adjust corner radius for roundness
                          ),
                        ),
                        child: Text(
                          'Reset',
                          style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () {
                          context.read<RemoteRecipeBloc>()
                              .add(GetRecipesEvent(
                              filters: context
                                  .read<FilterCubit>()
                                  .state
                                  .filtersMap, query: context
                              .read<RemoteRecipeBloc>()
                              .state
                              .query));
                          context.pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          elevation: 8.0,
                          minimumSize: const Size(130, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0),
                          ),
                        ),
                        child: Text(
                          'Apply',
                          style: GoogleFonts.outfit(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),

                    ],
                  ))
            ],
          );
        },);

    if (result == null) {
      // Handle the dismissal (e.g., update UI, perform actions)
      logger.log(Logger.level, 'bottom sheet dismissed');
    }
  }

}
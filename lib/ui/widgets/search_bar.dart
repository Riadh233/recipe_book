import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/recipe_filter_bloc.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/recipe_filter_event.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_event.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipes_bloc.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/ui/widgets/recipe_filter.dart';

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
                      showModalBottomSheet(
                        enableDrag: true,
                        isScrollControlled: true,
                        context: anchorContext,
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
                                          context.read<RecipeFilterCubit>()
                                              .onResetFilters();
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
                                          // context.read<RecipeFilterCubit>().onApplyFilters();
                                          context.pop();
                                          context.read<RemoteRecipeBloc>()
                                              .add(GetRecipesEvent(
                                              filters: context
                                                  .read<RecipeFilterCubit>()
                                                  .state
                                                  .filters, query: context
                                              .read<RemoteRecipeBloc>()
                                              .state
                                              .query));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.amber,
                                          elevation: 8.0,
                                          minimumSize: const Size(130, 40),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                16.0), // Adjust corner radius for roundness
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
                        },
                      );
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 13.0,
                      minimumSize: const Size(30, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            14.0), // Adjust corner radius for roundness
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
                5,
                    (index) =>
                    ListTile(
                      title: Text("item $index"),
                      onTap: () {
                        controller.closeView("item $index");
                        focusNode.unfocus();
                      },
                    ));
          },
          viewOnSubmitted: (query) {
            if (query.isNotEmpty) {
              context.read<RemoteRecipeBloc>().add(GetRecipesEvent(
                  query: query,
                  filters: context
                      .read<RecipeFilterCubit>()
                      .state
                      .filters));
              logger.log(
                  Logger.level, context
                  .read<RecipeFilterCubit>()
                  .state
                  .filters);
              controller.closeView(query);
              focusNode.unfocus();
            }
          },
        ),
      ),
    );
  }
}

// class RecipeFilterDraggableSheet extends StatefulWidget {
//
//   const RecipeFilterDraggableSheet({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _RecipeFilterDraggableSheetState();
// }
//
// class _RecipeFilterDraggableSheetState
//     extends State<RecipeFilterDraggableSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//         minChildSize: 0.5,
//         maxChildSize: 1,
//         initialChildSize: 0.5,
//         builder: (BuildContext context, ScrollController scrollController) {
//           return Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(28.0),
//                     topRight: Radius.circular(28.0)),
//                 color: Colors.white,
//               ),
//               child: SingleChildScrollView(
//                 controller: scrollController,
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('this is the filter sheet')
//                     ],
//                   ),
//                 ),
//               ));
//         });
//   }
// }

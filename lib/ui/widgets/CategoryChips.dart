import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/filter_state.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/recipe_filter_bloc.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_event.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipes_bloc.dart';

import '../../utils/constants.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: CUISINE_TYPES.length,
            separatorBuilder: (_,index){return const SizedBox(width: 5,);},
            itemBuilder: (_, index) {
            return BlocSelector<FilterCubit, FilterState, String?>(
                selector: (state) => state.filtersMap[CUISINE_TYPE],
                builder: (context, selectedChip) {
                  return InputChip(
                    label: Text(CUISINE_TYPES[index]),
                    showCheckmark: false,
                    selected: selectedChip == CUISINE_TYPES[index],
                    onSelected: (bool selected) {
                      if (selectedChip == CUISINE_TYPES[index]) {
                        context
                            .read<FilterCubit>()
                            .selectChip('All',CUISINE_TYPE);
                      } else {
                        context
                            .read<FilterCubit>()
                            .selectChip(CUISINE_TYPES[index],CUISINE_TYPE);

                        // context.read<RemoteRecipeBloc>()
                        //     .add(GetRecipesEvent(
                        //     filters: context
                        //         .read<FilterCubit>()
                        //         .state
                        //         .filtersMap, query: context
                        //     .read<RemoteRecipeBloc>()
                        //     .state
                        //     .query));
                      }
                    },
                    selectedColor: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the radius as needed
                    ),
                  );
                });
          }),
    );
  }
}

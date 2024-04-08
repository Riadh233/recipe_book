import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/recipe_filter_bloc.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/filter_state.dart';
import 'package:recipe_app/utils/constants.dart';

class InputChips extends StatelessWidget {
  final List<String> filters;
  final String filterName;

  const InputChips(
      {super.key, required this.filters, required this.filterName});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FilterCubit, FilterState,String?>(
      selector: (state) => state.filtersMap[filterName],
        builder: (BuildContext context, String? selectedChip) {
      return Wrap(
        alignment: WrapAlignment.start,
        direction: Axis.horizontal,
        spacing: 8.0,
        children: List<Widget>.generate(
          filters.length,
          (int index) {
            return filterName != DIET_TYPE
                ? InputChip(
                    label: Text(filters[index]),
                    selected: selectedChip == filters[index],
                    onSelected: (bool selected) {
                      if (selectedChip == filters[index]) {
                        context
                            .read<FilterCubit>()
                            .selectChip('',filterName);
                      } else {
                        context
                            .read<FilterCubit>()
                            .selectChip(filters[index],filterName);
                      }
                    },
                    selectedColor: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the radius as needed
                    ),
                  )
                : InputChip(
                    label: Text(filters[index]),
                    selected: stringToList(selectedChip)
                        .contains(filters[index]),
                    onSelected: (bool selected) {
                      var currentFilter =
                          stringToList(selectedChip);
                      if (currentFilter.contains(filters[index])) {
                        context.read<FilterCubit>().selectChip(
                            listToString(currentFilter..remove(filters[index])),filterName);
                      } else {
                        context.read<FilterCubit>().selectChip(
                            listToString(currentFilter..add(filters[index])),filterName);
                      }
                    },
                    selectedColor: Colors.amberAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the radius as needed
                    ),
                  );
          },
        ).toList(),
      );
    });
  }

  // Method to convert a comma-separated string to a list of strings
  List<String> stringToList(String? input) {
    if (input == null || input.isEmpty) return [];
    return input.split(',').map((String item) => item.trim()).toList();
  }

// Method to convert a list of strings to a comma-separated string
  String listToString(List<String> inputList) {
    return inputList.join(',');
  }
}

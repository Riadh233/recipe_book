import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/filter_state.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/recipe_filter_bloc.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';

class FilterRangeSlider extends StatelessWidget {
  final String filterName;
  final double minValue;
  final double maxValue;
  final String unit;

  const FilterRangeSlider(
      {super.key,
      required this.filterName,
      required this.minValue,
      required this.maxValue,
      required this.unit,});
  @override
  Widget build(BuildContext context) {
    return BlocSelector<FilterCubit, FilterState, RangeValues?>(
      selector: (state) => state.rangeValuesMap[filterName],
      builder: (context, currentRange) {
        currentRange ??= RangeValues(minValue, maxValue);
        logger.log(Logger.level, "rebuild triggered $filterName");
        return RangeSlider(
          values: currentRange,
          max: maxValue,
          min: minValue,
          activeColor: Colors.amber,
          inactiveColor: Colors.grey[300],
          onChanged: (range) =>
              context.read<FilterCubit>().updateSliderValue(range, filterName),
        );
      },
    );
  }
}
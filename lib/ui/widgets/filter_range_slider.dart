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
    return BlocSelector<FilterCubit, FilterState, String?>(
      selector: (state) => state.filtersMap[filterName],
      builder: (context, currentRange) {
        currentRange ??= '$minValue-$maxValue';
        logger.log(Logger.level, "rebuild triggered $filterName");
        return RangeSlider(
          values: getRangeValues(currentRange),
          max: maxValue,
          min: minValue,
          labels: RangeLabels(currentRange.split('-')[0] + unit,currentRange.split('-')[1] + unit),
          divisions: 50,
          activeColor: Colors.amber,
          inactiveColor: Colors.grey[300],
          onChanged: (range) =>
              context.read<FilterCubit>().updateSliderValue('${range.start.round()}-${range.end.round()}', filterName),
        );
      },
    );
  }

  RangeValues getRangeValues(String currentRange) {
    final rangeValues = currentRange.split('-');
    return RangeValues(double.parse(rangeValues[0]), double.parse(rangeValues[1]));
  }
}
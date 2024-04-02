import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/utils/constants.dart';

class FilterState  {
  final Map<String, RangeValues> rangeValuesMap;
  final Map<String, String> inputChipsMap;
  const FilterState({required this.rangeValuesMap,required this.inputChipsMap});

  factory FilterState.initial() {
    return const FilterState(
      rangeValuesMap: {
        CALORIES: RangeValues(0.0, 10000.0),
        TOTAL_TIME: RangeValues(0.0, 300.0),
      },
      inputChipsMap: {
        MEAL_TYPE:'',
        DISH_TYPE:'',
        DIET_TYPE:'',
      }
    );
  }
}

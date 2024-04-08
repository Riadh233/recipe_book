import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/utils/constants.dart';

class FilterState  {
  final Map<String, String> filtersMap;
  const FilterState({required this.filtersMap});

  factory FilterState.initial() {
    return const FilterState(
      filtersMap:DEFAULT_FILTERS,
    );
  }
}

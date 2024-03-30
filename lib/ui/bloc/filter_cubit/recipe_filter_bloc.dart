import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/filter_state.dart';

import '../../../utils/constants.dart';
import '../../screens/HomeScreen.dart';

class RecipeFilterCubit extends Cubit<RecipeFilterState> {
  RecipeFilterCubit() : super(FiltersInitialState(filters: DEFAULT_FILTERS));

  void onAddChoiceFilter(String filter,String filterName){
    final newFilters = Map.of(state.filters);
    newFilters[filterName] = filter;
    if (filter.isEmpty) {
      newFilters.remove(filterName);
    }
    emit(FilterAddedState(filters: newFilters));
  }

  void onAddRangeFilter(RangeValues filter,String filterName) {
    final newFilters = Map.of(state.filters);
    newFilters[filterName] = filter;
    logger.log(Logger.level, filter.toString());
    emit(FilterAddedState(filters: newFilters));
  }

  void onResetFilters() {
    emit(FiltersInitialState(filters:  DEFAULT_FILTERS));
  }
  void onApplyFilters() {
    emit(FiltersInitialState(filters:  {}));
  }
}

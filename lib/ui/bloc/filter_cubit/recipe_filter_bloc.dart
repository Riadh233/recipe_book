import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState.initial());

  void updateSliderValue(String newRange, String filterName) {
    final updatedRangeValuesMap = Map<String, String>.from(state.filtersMap);
    updatedRangeValuesMap[filterName] = newRange;
    emit(FilterState(filtersMap: updatedRangeValuesMap));
  }
  void selectChip(String filter,String filterName){
    final newFilters = Map.of(state.filtersMap);
    newFilters[filterName] = filter;

    emit(FilterState(filtersMap: newFilters));
  }
  void resetFilters(){
    emit(FilterState.initial());
  }
}

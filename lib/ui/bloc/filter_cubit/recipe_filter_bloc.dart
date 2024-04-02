import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState.initial());

  void updateSliderValue(RangeValues newRange, String filterName) {
    final updatedRangeValuesMap = Map<String, RangeValues>.from(state.rangeValuesMap);
    updatedRangeValuesMap[filterName] = newRange;
    emit(FilterState(rangeValuesMap: updatedRangeValuesMap,inputChipsMap: state.inputChipsMap));
  }
  void selectChip(String filter,String filterName){
    final newFilters = Map.of(state.inputChipsMap);
    newFilters[filterName] = filter;

    emit(FilterState(rangeValuesMap: state.rangeValuesMap,inputChipsMap: newFilters));
  }
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/filter_state.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/recipe_filter_bloc.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/utils/constants.dart';

class FilterRangeSlider extends StatefulWidget {
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
  State<StatefulWidget> createState() => _RangeSliderState();
}

class _RangeSliderState extends State<FilterRangeSlider> {
  late RangeValues currentRange;
  late RangeValues initialRange;
  late RecipeFilterCubit cubit;
 // late void Function(RangeValues range) onApplyRange;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentRange = RangeValues(widget.minValue, widget.maxValue);
    initialRange = RangeValues(widget.minValue, widget.maxValue);
  }
  @override
  void didChangeDependencies() {
    cubit =  context
        .read<RecipeFilterCubit>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    cubit.onAddRangeFilter(currentRange, widget.filterName);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeFilterCubit, RecipeFilterState>(
      buildWhen: (prevState,currState){
        if(currState is FiltersInitialState) {
          logger.log(Logger.level, 'reset detected');
          return true;
        }
        return false;
      },
        builder: (context, state) {
      return RangeSlider(
          values: currentRange,
          max: widget.maxValue,
          min: widget.minValue,
          labels: RangeLabels('${currentRange.start.round()}${widget.unit}',
              '${currentRange.end.round().toString()} ${widget.unit}'),
          divisions: 50,
          activeColor: Colors.amber,
          inactiveColor: Colors.grey[300],
          onChanged: (range) {
            setState(() {
              currentRange = range;
            });
          });
    });
  }
}

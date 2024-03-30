import 'package:flutter/material.dart';

abstract class RecipeFilterEvent{}

class AddChoiceFilterEvent extends RecipeFilterEvent{
  final String filter;
  final String filterType;
  AddChoiceFilterEvent({required this.filter, required this.filterType});
}

class AddRangeFilterEvent extends RecipeFilterEvent{
  final RangeValues filter;
  final String filterType;
  AddRangeFilterEvent({required this.filter, required this.filterType});
}
class ApplyFiltersEvent extends RecipeFilterEvent{}
class ResetFiltersEvent extends RecipeFilterEvent{}
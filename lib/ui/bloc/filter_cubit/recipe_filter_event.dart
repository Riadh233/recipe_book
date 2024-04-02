// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:recipe_app/domain/model/recipe.dart';
//
// abstract class RecipeFilterEvent extends Equatable {
//   final Map<String,dynamic> filters;
//
//   const RecipeFilterEvent(this.filters);
//
//   @override
//   List<Object> get props => [];
// }
// class RecipeFilterInitial extends RecipeFilterEvent{
//   RecipeFilterInitial(super.filters);
//
//   @override
//   List<Object> get props => [super.filters];
// }
//
// class RecipeAddChoiceFilter extends RecipeFilterEvent{
//   final String filterName;
//   RecipeAddChoiceFilter(super.filters, this.filterName);
//
//   @override
//   // TODO: implement props
//   List<Object> get props => [super.filters[filterName]];
// }
// class RangeValuesChanged extends RecipeFilterEvent {
//   final RangeValues newValues;
//
//   const RangeValuesChanged(this.newValues) : super(null);
//
//   @override
//   List<Object> get props => [newValues];
// }
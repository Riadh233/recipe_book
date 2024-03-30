import 'package:equatable/equatable.dart';

abstract class RecipeFilterState extends Equatable{
  final Map<String,dynamic> filters;

  const RecipeFilterState({required this.filters});

  @override
  List<Object?> get props => [filters];
}
class FilterAddedState extends RecipeFilterState{
  FilterAddedState({required super.filters});
}
class FiltersInitialState extends RecipeFilterState{
  FiltersInitialState({required super.filters});
}
class FiltersAppliedState extends RecipeFilterState{
  FiltersAppliedState({required super.filters});
}

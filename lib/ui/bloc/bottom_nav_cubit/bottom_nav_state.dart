import 'package:equatable/equatable.dart';

class BottomNavState extends Equatable{

  const BottomNavState({required this.selectedTab});

  final int selectedTab;

  @override
  List<Object?> get props => [selectedTab];
}
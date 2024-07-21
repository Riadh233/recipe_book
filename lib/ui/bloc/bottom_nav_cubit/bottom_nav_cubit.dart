import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/bottom_nav_cubit/bottom_nav_state.dart';
import '../../screens/HomeScreen.dart';

class BottomNavCubit extends Cubit<BottomNavState>{
  BottomNavCubit() : super(const BottomNavState(selectedTab: 0));

  void selectedTabChanged(int index){
    logger.log(Logger.level, 'selected tab $index');
    emit(BottomNavState(selectedTab: index));
  }
}
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:recipe_app/domain/usecases/get_theme_usecase.dart';
import 'package:recipe_app/domain/usecases/save_theme_usecase.dart';

import 'app_theme_event.dart';
import 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent,AppThemeState>{
  AppThemeBloc({required this.saveTheme , required this.getTheme}) : super(AppThemeState(isDarkTheme: false)){
    on<AppThemeStarted>(_onAppStarted);
    on<AppThemeChanged>(_onAppThemeChanged);

}

  final SaveThemeUseCase saveTheme;
  final GetThemeUseCase getTheme;


   void _onAppStarted(AppThemeStarted event, Emitter<AppThemeState> emit) async {
     final appTheme = await getTheme(params: false);
     emit(AppThemeState(isDarkTheme: appTheme));
  }

  void _onAppThemeChanged(AppThemeChanged event, Emitter<AppThemeState> emit) async{
     await saveTheme(params: event.isDarkTheme);
     emit(AppThemeState(isDarkTheme: event.isDarkTheme));
  }
}
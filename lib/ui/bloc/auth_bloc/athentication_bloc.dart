import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/domain/repository/auth_repository.dart';
import 'package:recipe_app/ui/bloc/auth_bloc/athentication_state.dart';
import 'package:recipe_app/ui/bloc/auth_bloc/authentication_event.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';

import '../../../data/auth/user.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.authenticationRepository})
      : super(const AuthenticationState.unknown()) {
    on<AppStarted>(_onAppStarted);
    on<AppUserChanged>(_userChanged);
    on<AppLogoutRequested>(_logoutRequested);
    _userSubscription = authenticationRepository.getUserStream().listen((user) {
      add(AppUserChanged(user));
    });
  }

  final AuthenticationRepository authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onAppStarted(AppStarted event, Emitter<AuthenticationState> emit) async {
    try {
      final user = await authenticationRepository.getCurrentUser();
      emit(user.isEmpty
          ? const AuthenticationState.unauthenticated()
          : AuthenticationState.authenticated(user));
    } catch (error) {
      logger.log(Logger.level, error);
      emit(const AuthenticationState.unknown());
    }
  }

  void _userChanged(AppUserChanged event, Emitter<AuthenticationState> emit) {
    emit(event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated());
  }

  void _logoutRequested(
      AppLogoutRequested event, Emitter<AuthenticationState> emit) {
    unawaited(authenticationRepository.logOut());
  }
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

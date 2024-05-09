
import '../../../data/auth/user.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class AppLogoutRequested extends AuthenticationEvent {
  const AppLogoutRequested();
}

final class AppUserChanged extends AuthenticationEvent {
  const AppUserChanged(this.user);

  final User user;
}

final class AppStarted extends AuthenticationEvent {
  const AppStarted();
}

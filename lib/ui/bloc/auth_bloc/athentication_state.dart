import 'package:equatable/equatable.dart';
import 'package:recipe_app/data/auth/user.dart';

enum AuthenticationStatus{
  authenticated,
  unauthenticated,
  unknown
}

final class AuthenticationState extends Equatable{
  const AuthenticationState._({
    required this.status,
    this.user = User.empty,
  });
  const AuthenticationState.authenticated(User user) : this._(status: AuthenticationStatus.authenticated,user: user);
  const AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated,user: User.empty);
  const AuthenticationState.unknown() : this._(status: AuthenticationStatus.unknown,user: User.empty);

  final User user;
  final AuthenticationStatus status;

  @override
  List<Object?> get props => [user,status];
}
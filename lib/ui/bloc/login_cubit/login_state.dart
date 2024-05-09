import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:recipe_app/utils/form_inputs/email.dart';
import 'package:recipe_app/utils/form_inputs/password.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.hidePassword = false,
    this.errorMessage,
    this.resetPasswordMessage
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;
  final String? resetPasswordMessage;
  final bool hidePassword;

  LoginState copyWith(
      {Email? email, Password? password, FormzSubmissionStatus? status, bool? isValid, bool? hidePassword, String? resetPasswordMessage, String? errorMessage}) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        hidePassword: hidePassword ?? this.hidePassword,
        errorMessage: errorMessage ?? this.errorMessage,
        resetPasswordMessage: resetPasswordMessage ?? this.resetPasswordMessage,
    );
  }

  @override
  List<Object?> get props =>
      [email, password, status, isValid, hidePassword, errorMessage,resetPasswordMessage];
}
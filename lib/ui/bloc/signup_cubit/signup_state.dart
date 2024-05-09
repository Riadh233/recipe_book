import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:recipe_app/utils/form_inputs/confirmed_password.dart';

import '../../../utils/form_inputs/email.dart';
import '../../../utils/form_inputs/password.dart';
import '../../../utils/form_inputs/username.dart';

class SignUpState extends Equatable {
  const SignUpState(
      {this.email = const Email.pure(),
      this.username = const Username.pure(),
      this.password = const Password.pure(),
      this.status = FormzSubmissionStatus.initial,
      this.confirmedPassword = const ConfirmedPassword.pure(),
      this.isValid = false,
      this.hidePassword = false,
      this.errorMessage});

  final Email email;
  final Username username;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final bool hidePassword;
  final ConfirmedPassword confirmedPassword;
  final String? errorMessage;

  SignUpState copyWith(
      {Email? email,
      Username? username,
      Password? password,
      ConfirmedPassword? confirmedPassword,
      FormzSubmissionStatus? status,
      bool? isValid,
      bool? hidePassword,
      String? errorMessage}) {
    return SignUpState(
        email: email ?? this.email,
        username: username ?? this.username,
        password: password ?? this.password,
        confirmedPassword: confirmedPassword ?? this.confirmedPassword,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid,
        hidePassword: hidePassword ?? this.hidePassword,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props =>
      [email,username, password, confirmedPassword, status, isValid, hidePassword, errorMessage];
}

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:recipe_app/data/repository/auth_repository_impl.dart';
import 'package:recipe_app/domain/repository/auth_repository.dart';
import 'package:recipe_app/ui/bloc/signup_cubit/signup_state.dart';
import 'package:recipe_app/utils/form_inputs/confirmed_password.dart';
import 'package:recipe_app/utils/form_inputs/email.dart';
import 'package:recipe_app/utils/form_inputs/password.dart';

import '../../../utils/form_inputs/username.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authenticationRepository) : super(const SignUpState());

  AuthenticationRepository authenticationRepository;

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
        username: username,
        isValid:
        Formz.validate([username,state.email, state.password, state.confirmedPassword])));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email,
        isValid:
            Formz.validate([email, state.password, state.confirmedPassword])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword =
        ConfirmedPassword.dirty(password: password.value, value: value);
    emit(state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([state.email, password, confirmedPassword])));
  }
  void passwordVisibilityChanged() {
    emit(state.copyWith(hidePassword: !(state.hidePassword)));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword =
        ConfirmedPassword.dirty(password: state.password.value, value: value);
    emit(state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid:
            Formz.validate([state.email, state.password, confirmedPassword])));
  }

  void signUp() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await authenticationRepository.signUp(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}

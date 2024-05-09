import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/data/repository/auth_repository_impl.dart';
import 'package:recipe_app/domain/repository/auth_repository.dart';
import 'package:recipe_app/ui/bloc/login_cubit/login_state.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/utils/form_inputs/email.dart';
import 'package:recipe_app/utils/form_inputs/password.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository) : super(const LoginState());

  AuthenticationRepository authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
        email: email, isValid: Formz.validate([email, state.password])));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
        password: password, isValid: Formz.validate([state.email, password])));
  }
  void confirmationCodeChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
        password: password, isValid: Formz.validate([state.email, password])));
  }
  void passwordVisibilityChanged() {
    emit(state.copyWith(hidePassword: !(state.hidePassword)));
  }

  void signInWithCredentials() async {
    if (!state.isValid){
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await authenticationRepository.signInWithEmailAndPassword(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  void signInWithGoogle() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await authenticationRepository.signInWithGoogle();
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on LogInWithGoogleFailure catch (e) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.message));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
  void resetPassword() async{
    if(state.email.isNotValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try{
      await authenticationRepository.resetPassword(email: state.email.value);
      emit(state.copyWith(status: FormzSubmissionStatus.success,resetPasswordMessage: null));
    }on ResetPasswordException catch(e){
      emit(state.copyWith(resetPasswordMessage: e.message,status: FormzSubmissionStatus.failure),);
    }
  }
}

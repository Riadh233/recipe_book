import 'package:formz/formz.dart';

enum UsrnameValidationError{
  invalid
}

class Username extends FormzInput<String,UsrnameValidationError>{
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  static final RegExp _usernameRegExp = RegExp(
    r'^[A-Za-z][A-Za-z0-9_]{5,29}$',
  );

  @override
  UsrnameValidationError? validator(String value) {
    return _usernameRegExp.hasMatch(value ?? '') ? null : UsrnameValidationError.invalid;
  }
}
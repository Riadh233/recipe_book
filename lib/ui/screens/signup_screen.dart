import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_app/di/app_service.dart';
import 'package:recipe_app/ui/bloc/signup_cubit/signup_cubit.dart';
import 'package:recipe_app/ui/bloc/signup_cubit/signup_state.dart';

import '../../utils/app_routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: BlocProvider<SignUpCubit>(
        create: (context) => getIt(),
        child: _SignUpForm(),
      ),
    );
  }
}

class _SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (prevState, currState) {
        return prevState.status != currState.status;
      },
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(state.errorMessage ?? 'failed to create account')));
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sign Up',
                    style: GoogleFonts.outfit(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(color: Colors.black87, fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: const Text('Login',
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.amberAccent,
                                decorationStyle: TextDecorationStyle.solid,
                                decorationThickness: 1)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Name',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                  const _UserNameInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Email',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                  const _EmailInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Password',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                  const _PasswordInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Confirm Password',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      )),
                  const _ConfirmPasswordInput(),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const SignUpButton(),
          ],
        ),
      ),
    );
  }
}


class _UserNameInput extends StatelessWidget {
  const _UserNameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (prevState, currState) {
          return prevState.username != currState.username;
        }, builder: (context, state) {
      return TextField(
        onChanged: (value) {
          context.read<SignUpCubit>().usernameChanged(value);
        },
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.amber,
              ), // Change the color to whatever you want
            ),
            hintText: 'Enter your Name',
            labelText: null,
            errorText:
            state.username.displayError != null ? 'invalid username' : null),
        style:
        const TextStyle(fontSize: 15.0, height: 0.9, color: Colors.black),
      );
    });
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (prevState, currState) {
      return prevState.email != currState.email;
    }, builder: (context, state) {
      return TextField(
        onChanged: (value) {
          context.read<SignUpCubit>().emailChanged(value);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.amber,
              ), // Change the color to whatever you want
            ),
            hintText: 'Enter your email',
            labelText: null,
            errorText:
                state.email.displayError != null ? 'invalid email' : null),
        style:
            const TextStyle(fontSize: 15.0, height: 0.9, color: Colors.black),
      );
    });
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (prevState, currState) {
      return prevState.password != currState.password
      || prevState.hidePassword != currState.hidePassword;
    }, builder: (context, state) {
      return TextField(
        onChanged: (value) {
          context.read<SignUpCubit>().passwordChanged(value);
        },
        obscureText: state.hidePassword,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.amber,
              ), // Change the color to whatever you want
            ),
            hintText: 'Enter your password',
            labelText: null,
            suffixIcon: IconButton(
                onPressed: () {
                  context.read<SignUpCubit>().passwordVisibilityChanged();
                },
                icon: Icon(state.hidePassword ? Icons.visibility_off : Icons.visibility)
                ),
            errorText: (state.password.displayError) != null
                ? 'invalid password'
                : null),
        style:
            const TextStyle(fontSize: 15.0, height: 0.9, color: Colors.black),
      );
    });
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (prevState, currState){ return prevState.confirmedPassword != currState.confirmedPassword ||
            prevState.hidePassword != currState.hidePassword;},
        builder: (context, state) {
          return TextField(
            onChanged: (value) {
              context.read<SignUpCubit>().confirmedPasswordChanged(value);
            },
            keyboardType: TextInputType.text,
            obscureText: state.hidePassword,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amber,
                  ), // Change the color to whatever you want
                ),
                hintText: ' Confirm your Password',
                labelText: null,
                suffixIcon: IconButton(
                    onPressed: () {
                      context.read<SignUpCubit>().passwordVisibilityChanged();
                    },
                    icon: Icon(state.hidePassword ? Icons.visibility_off : Icons.visibility)
                ),
                errorText:
                state.confirmedPassword.displayError != null ? "passwords don't match" : null),
            style:
            const TextStyle(fontSize: 15.0, height: 0.9, color: Colors.black),
          );
        });
  }
}


class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(builder: (context, state) {
      return ElevatedButton(
          onPressed: () {
            if (state.isValid) {
              context.read<SignUpCubit>().signUp();
            } else {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                    const SnackBar(content: Text('invalid email or password')));
            }
          },
          style: ButtonStyle(
              fixedSize:
                  MaterialStateProperty.all<Size>(const Size(300.0, 48.0)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.amberAccent)),
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ));
    });
  }
}

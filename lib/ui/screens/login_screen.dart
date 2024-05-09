import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/di/app_service.dart';
import 'package:recipe_app/ui/bloc/login_cubit/login_cubit.dart';
import 'package:recipe_app/ui/bloc/login_cubit/login_state.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import '../../utils/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen([this.params]);

  final String? params;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginCubit>(
        create: (context) => getIt(),
        child: const _LoginForm(),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (prevState, currState) {
        return prevState.status != currState.status;
      },
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text(state.errorMessage ?? 'failed to login')));
        }
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Image(
                image: Image.asset('assets/images/food_image.jpg').image,
                height: 160,
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome!',
                    style: GoogleFonts.outfit(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text('Email',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                      )),
                  const _EmailInput(),
                  const SizedBox(
                    height: 15,
                  ),
                  Text('Password',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                      )),
                  const _PasswordInput(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Builder(
                        builder: (builderContext) {
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(AppRoutes.ResetPassword);
                            },
                            child: Text('Forgot Password?',
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.amber,
                                )),
                          );
                        }
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const _LoginButton(),
            const SizedBox(
              height: 10,
            ),
            const Text('OR',style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            ),),
            const SizedBox(
              height: 10,
            ),
            _SingInWithGoogleButton(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(color: Colors.black87, fontSize: 12),
                ),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutes.SignUp);
                  },
                  child: const Text('Sign Up',
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
            )
          ],
        ),
      ),
    );
  }
}

class _SingInWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return ElevatedButton(
          onPressed: () {
              context.read<LoginCubit>().signInWithGoogle();
          },
          style: ButtonStyle(
              fixedSize:
              MaterialStateProperty.all<Size>(const Size(300.0, 48.0)),
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.grey[300]!),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: Image.asset('assets/images/google_icon.png').image,
                height: 30,
                width: 30,
              ),
              const SizedBox(width: 40,),
               Text(
                'Login with Google',
                style: TextStyle(color: Colors.grey[900]),
              ),
            ],
          ));
    });
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (prevState, currState) {
      return prevState.email != currState.email;
    }, builder: (context, state) {
      return TextField(
        onChanged: (value) {
          context.read<LoginCubit>().emailChanged(value);
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
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (prevState, currState) {
      return prevState.password != currState.password ||
          prevState.hidePassword != currState.hidePassword;
    }, builder: (context, state) {
      return TextField(
        onChanged: (value) {
          context.read<LoginCubit>().passwordChanged(value);
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
                context.read<LoginCubit>().passwordVisibilityChanged();
              },
              icon: Icon(
                  state.hidePassword ? Icons.visibility_off : Icons.visibility),
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

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return ElevatedButton(
          onPressed: () {
            if (state.isValid) {
              context.read<LoginCubit>().signInWithCredentials();
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
            'Login',
            style: TextStyle(color: Colors.white),
          ));
    });
  }
}

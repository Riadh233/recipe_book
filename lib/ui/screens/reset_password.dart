import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/login_cubit/login_cubit.dart';
import 'package:recipe_app/ui/bloc/login_cubit/login_state.dart';
import '../../di/app_service.dart';
import 'HomeScreen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>.value(
      value: getIt(),
      child: Scaffold(
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
          body: _ResetPasswordForm()),
    );
  }
}

class _ResetPasswordForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (prevState,currState){return prevState.status != currState.status;},
      listener: (context, state) {
        logger.log(Logger.level, state.resetPasswordMessage);
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'invalid email')));
        }
        if(state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text('reset link sent to your email')));
          context.pop();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reset Password',
              style: GoogleFonts.outfit(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text('Email',
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                )),
            _EmailInput(),
            const SizedBox(
              height: 40,
            ),
            const _ResetPasswordButton(),
            //create account text
          ],
        ),
      ),
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  const _ResetPasswordButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                  context.read<LoginCubit>().resetPassword();

              },
              style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(300.0, 48.0)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amberAccent)),
              child: const Text(
                'Send Reset Password Link',
                style: TextStyle(color: Colors.white),
              )),
        ],
      );
    });
  }
}

class _EmailInput extends StatelessWidget {
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

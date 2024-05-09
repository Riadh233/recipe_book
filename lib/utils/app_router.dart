import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/di/app_service.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/ui/bloc/login_cubit/login_cubit.dart';
import 'package:recipe_app/ui/screens/DetailScreen.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/ui/screens/login_screen.dart';
import 'package:recipe_app/ui/screens/reset_password.dart';
import 'package:recipe_app/ui/screens/signup_screen.dart';
import 'package:recipe_app/utils/app_routes.dart';

class AppRouter {
  static GoRouter router(bool isAuth) {
    final router = GoRouter(
      initialLocation: '/home',
      routes: <RouteBase>[
        GoRoute(
          path: '/home',
          name:AppRoutes.Home,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: '/login',
          name:AppRoutes.Login,
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'reset_password',
              name:AppRoutes.ResetPassword,
              builder: (BuildContext context, GoRouterState state) {
                return const ResetPasswordScreen();
              },
            ),
          ]
        ),
        GoRoute(
          path: '/signup',
          name:AppRoutes.SignUp,
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpScreen();
          },
        ),
        GoRoute(
          path: '/details',
          name: AppRoutes.Details,
          builder: (BuildContext context, GoRouterState state) {
            return DetailScreen(state.extra as Recipe?);
          },
        ),
      ],
      redirect: (context,state){
        logger.log(Logger.level, isAuth);
        if (!isAuth) {
          // Unauthenticated user:
          if (state.matchedLocation == '/home') {
            // Redirect from details route(s) to login:
            return '/login';
          } else {
            // Allow access to other routes (home, signup, etc.)
            return null; // No redirection
          }
        } else {
          // Authenticated user:
          if (state.matchedLocation == '/login' || state.matchedLocation == '/signup') {
            // Redirect from login/signup to home:
            return '/home';
          } else {
            // Allow access to all routes
            return null; // No redirection
          }
        }
      }
    );
    return router;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/ui/screens/DetailScreen.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
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
          path: '/details',
          name: AppRoutes.Details,
          builder: (BuildContext context, GoRouterState state) {
            return DetailScreen(state.extra as Recipe?);
          },
        ),
      ],
    );
    return router;
  }
}

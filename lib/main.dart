import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/data/auth/user.dart';
import 'package:recipe_app/firebase_options.dart';
import 'package:recipe_app/ui/app_theme.dart';
import 'package:recipe_app/ui/bloc/app_theme_bloc/app_theme_bloc.dart';
import 'package:recipe_app/ui/bloc/app_theme_bloc/app_theme_event.dart';
import 'package:recipe_app/ui/bloc/auth_bloc/athentication_bloc.dart';
import 'package:recipe_app/ui/bloc/auth_bloc/athentication_state.dart';
import 'package:recipe_app/ui/bloc/auth_bloc/authentication_event.dart';
import 'package:recipe_app/ui/bloc/bookmark_cubit/bookmark_cubit.dart';
import 'package:recipe_app/ui/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/recipe_filter_bloc.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_bloc.dart';
import 'package:recipe_app/ui/bloc/firestore_bloc/firestore_event.dart';
import 'package:recipe_app/ui/bloc/my_bloc_observer.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipe_event.dart';
import 'package:recipe_app/ui/bloc/remote/remote_recipes_bloc.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import 'package:recipe_app/utils/app_router.dart';
import 'package:recipe_app/utils/constants.dart';
import 'di/app_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDependencies();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    logger.log(Logger.level, 'main build called');
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteRecipeBloc>(
            create: (context) => getIt() ..add(const GetRecipesEvent(
                query: '', filters: DEFAULT_FILTERS))),
        BlocProvider<AuthenticationBloc>(
            create: (context) => getIt()..add(const AppStarted())),
        BlocProvider<FilterCubit>(
            create: (context) => getIt()),
        BlocProvider<AppThemeBloc>(
            create: (context) => getIt()..add(const AppThemeStarted())),
        BlocProvider<FirestoreBloc>(
            create: (context) => getIt()..add(GetBookmarkedRecipesEvent())),
        BlocProvider<BookmarkCubit>(
            create: (context) => getIt()),
        BlocProvider<BottomNavCubit>(
            create: (context) => getIt())
      ],
      child: const AppView()
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final authState = context.watch<AuthenticationBloc>().state;
      final themeState = context.watch<AppThemeBloc>().state;
      final theme =
      themeState.isDarkTheme ? AppTheme.dark() : AppTheme.light();
      final router = AppRouter.router(
          authState.status == AuthenticationStatus.authenticated);
      logger.log(Logger.level, 'auth state:${authState.status == AuthenticationStatus.authenticated}');
      return MaterialApp.router(
        title: 'Flutter Demo',
        theme: theme,
        debugShowCheckedModeBanner: false,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      );
    });
  }
}

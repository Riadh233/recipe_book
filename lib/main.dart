import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/data/auth/user.dart';
import 'package:recipe_app/firebase_options.dart';
import 'package:recipe_app/ui/bloc/auth_bloc/athentication_bloc.dart';
import 'package:recipe_app/ui/bloc/auth_bloc/athentication_state.dart';
import 'package:recipe_app/ui/bloc/auth_bloc/authentication_event.dart';
import 'package:recipe_app/ui/bloc/filter_cubit/recipe_filter_bloc.dart';
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
    return BlocProvider<AuthenticationBloc>(
      create: (context) => getIt()..add(const AppStarted()),
      child: BlocBuilder<AuthenticationBloc,AuthenticationState>(
        builder: (context,state) {
          logger.log(Logger.level, state.status);
          final router = AppRouter.router(state.status == AuthenticationStatus.authenticated);
          return MaterialApp.router(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent),
                    useMaterial3: true,
                  ),
                  routerDelegate: router.routerDelegate,
                  routeInformationParser: router.routeInformationParser,
                  routeInformationProvider: router.routeInformationProvider,

            );
        }
      )
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/ui/bloc/app_theme_bloc/app_theme_bloc.dart';
import 'package:recipe_app/ui/bloc/app_theme_bloc/app_theme_event.dart';
import 'package:recipe_app/ui/bloc/auth_bloc/authentication_event.dart';
import 'package:recipe_app/ui/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';

import '../bloc/auth_bloc/athentication_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar:  AppBar(
          elevation: 0,
          title: Text('Profile', style: theme.textTheme.headlineSmall),
          centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage('assets/images/pizza_w700.png'),
              ),
              const SizedBox(
                height: 25,
              ),
              ProfileListItem(
                  icon: Icons.bookmark_outline,
                  text: 'My Bookmarked Recipes',
                  onItemClicked: () {
                    context.read<BottomNavCubit>().selectedTabChanged(1);
                  }),
              AppThemeItem(),
              ProfileListItem(
                  icon: Icons.logout,
                  text: 'Logout',
                  onItemClicked: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(const AppLogoutRequested());
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onItemClicked;

  const ProfileListItem(
      {super.key,
      required this.icon,
      required this.onItemClicked,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onItemClicked,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 22),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.amberAccent.withOpacity(0.3),
              child: Icon(
                icon,
                color: Colors.amberAccent,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
                child: Text(
              text,
              style: theme.textTheme.labelLarge,
            )),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Colors.amberAccent,
            )
          ],
        ),
      ),
    );
  }
}

class AppThemeItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 22),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.amberAccent.withOpacity(0.3),
            child: const Icon(
              Icons.nightlight_outlined,
              color: Colors.amberAccent,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: Text(
            'Dark Theme',
            style: theme.textTheme.labelLarge,
          )),
          Switch(
              value: context.read<AppThemeBloc>().state.isDarkTheme,
              onChanged: (value) {
                context.read<AppThemeBloc>().add(AppThemeChanged(value));
              })
        ],
      ),
    );
  }
}

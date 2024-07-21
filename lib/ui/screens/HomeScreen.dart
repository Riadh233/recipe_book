import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/ui/bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import 'package:recipe_app/ui/bloc/bottom_nav_cubit/bottom_nav_state.dart';
import 'package:recipe_app/ui/screens/bookmark_screen.dart';
import 'package:recipe_app/ui/screens/discover_recipes_screen.dart';
import 'package:recipe_app/ui/screens/profile_screen.dart';


final logger = Logger();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<BottomNavCubit,BottomNavState,int>(
      selector: (state) => state.selectedTab,
      builder: (context,int selectedTab) {
        return Scaffold(
            body: _getSelectedScreen(selectedTab),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark),
                    label: 'bookmark'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'profile'
                ),
              ],
              currentIndex: selectedTab,
              onTap: (index){
                context.read<BottomNavCubit>().selectedTabChanged(index);
              },
            )
        );
      }
    );
  }
  Widget _getSelectedScreen(int index){
    switch(index){
      case 0 :
        return DiscoverRecipesScreen();
      case 1 :
        return BookmarkScreen();
      case 2 :
        return ProfileScreen();

      default : return DiscoverRecipesScreen();
    }
  }
}

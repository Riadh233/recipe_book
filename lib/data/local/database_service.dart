import 'package:recipe_app/data/auth/user.dart';
import 'package:hive/hive.dart';

import '../../utils/constants.dart';

class DatabaseService{
  final String boxName = 'recipe box';
  Future<Box<User>> get _box async => await Hive.openBox(boxName);
  Future<Box<bool>> get _themeBox async => await Hive.openBox('theme box');

  void saveUser(User user) async {
    final box = await _box;
    box.put(user.id,user);
  }
  void deleteUser() async {
    final box = await _box;
    box.clear();
  }

  Future<User> getCurrentUser() async{
    final box = await _box;
    final currentUser = box.values.isEmpty ? User.empty : box.values.last;
    return currentUser;
  }
  Future<void> saveAppTheme(bool isDarkTheme) async{
    final themeBox = await _themeBox;
    themeBox.put(APP_THEME_KEY,isDarkTheme);
  }
  Future<bool> getAppTheme() async {
    final themeBox = await _themeBox;
    return themeBox.get(APP_THEME_KEY) ?? false;
  }
}
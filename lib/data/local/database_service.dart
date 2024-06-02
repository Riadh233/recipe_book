import 'package:recipe_app/data/auth/user.dart';
import 'package:hive/hive.dart';

class DatabaseService{
  final String boxName = 'recipe box';
  Future<Box<User>> get _box async => await Hive.openBox(boxName);

  void saveUser(User user) async {
    final box = await _box;
    box.put(user.id,user);
  }
  void deleteUser(String id) async {
    final box = await _box;
    box.delete(id);
  }

  Future<User> getCurrentUser() async{
    final box = await _box;
    return box.values.last;
  }
}
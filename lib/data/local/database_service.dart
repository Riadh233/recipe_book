import 'package:recipe_app/data/local/recipe_entity.dart';
import 'package:hive/hive.dart';

class DatabaseService{
  final String boxName = 'recipe box';
  Future<Box<RecipeEntity>> get _box async => await Hive.openBox(boxName);

  Future saveRecipe(RecipeEntity recipe) async{
    var box = await _box;
    box.put(recipe.url,recipe);
  }
  Future deleteRecipe(String id) async{
    var box = await _box;
    box.delete(id);

  }
  Future<List<RecipeEntity>> getAllRecipes() async{
    var box = await _box;
    return box.values.toList();
  }
}
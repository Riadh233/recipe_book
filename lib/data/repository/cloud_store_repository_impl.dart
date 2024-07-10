import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:recipe_app/data/auth/user.dart';
import 'package:recipe_app/data/firestore/firestore_recipe.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/domain/repository/cloud_store_repository.dart';
import 'package:recipe_app/ui/screens/HomeScreen.dart';
import '../local/database_service.dart';

class CloudStoreRepositoryImpl implements CloudStoreRepository {
  final FirebaseFirestore _fireStoreInstance;
  final DatabaseService _cache;

  CloudStoreRepositoryImpl(
      {FirebaseFirestore? fireStoreInstance, required DatabaseService cache})
      : _fireStoreInstance = fireStoreInstance ?? FirebaseFirestore.instance,
        _cache = cache;

  @override
  Future<void> bookmarkRecipe(Recipe recipe) async {
    try {
      final currentUser = await _cache.getCurrentUser();
      if (currentUser == User.empty) return;
      logger.log(Logger.level, currentUser.id);
      final collectionRef = _fireStoreInstance.collection('users');
      final userDoc = collectionRef.doc(currentUser.id);
      final recipesSubCollection = userDoc.collection('recipes');
      recipesSubCollection.add(FirestoreRecipe.fromRecipe(recipe).toFirestore());
    } on Exception catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Recipe>> getBookmarkedRecipes() async {
    final currentUser = await _cache.getCurrentUser();
    if (currentUser == User.empty) return [];
    final userDoc = _fireStoreInstance.collection('users').doc(currentUser.id);
    final recipesSubCollection = userDoc.collection('recipes');
    final querySnapshot = await recipesSubCollection.get();
    final Iterable<Recipe> bookmarkedRecipes = querySnapshot.docs.map((snapshot) {
      return Recipe.fromFirestoreRecipe(FirestoreRecipe.fromFirestore(snapshot));
    });
    return bookmarkedRecipes.toList();
  }

  @override
  Future<void> unbookmarkRecipe(Recipe recipe) async {
    try {
      final currentUser = await _cache.getCurrentUser();
      if (currentUser == User.empty) return;
      final userDoc = _fireStoreInstance.collection('users').doc(currentUser.id);
      final recipesSubCollection = userDoc.collection('recipes');
      final querySnapshot = await recipesSubCollection
          .where('url', isEqualTo: recipe.url)
          .get();
      WriteBatch batch = _fireStoreInstance.batch();
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } on Exception catch (e) {
      rethrow;
    }
  }
  @override
  Future<void> deleteAllBookmarkedRecipes() async {
    try {
      final currentUser = await _cache.getCurrentUser();
      if (currentUser == User.empty) return;
      final userDoc = _fireStoreInstance.collection('users').doc(currentUser.id);
      final recipesSubCollection = userDoc.collection('recipes');
      final querySnapshot = await recipesSubCollection.get();
      WriteBatch batch = _fireStoreInstance.batch();
      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } on Exception catch (e) {
      rethrow;
    }
  }
  @override
  Future<bool> isRecipeBookmarked(Recipe recipe) async {
    try {
      final currentUser = await _cache.getCurrentUser();
      if (currentUser == User.empty) return false;
      final userDoc = _fireStoreInstance.collection('users').doc(currentUser.id);
      final recipesSubCollection = userDoc.collection('recipes');
      final querySnapshot = await recipesSubCollection
          .where('url', isEqualTo: recipe.url)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } on Exception catch (e) {
      rethrow;
    }
  }
}

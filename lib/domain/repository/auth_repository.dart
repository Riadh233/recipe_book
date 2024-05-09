import '../../data/auth/user.dart';

abstract class AuthenticationRepository {
  Future<void> signUp({required String email, required String password});

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<void> signInWithGoogle();

  Future<void> logOut();

  Future<void> resetPassword({required String email});

  Future<User> getCurrentUser();

  Stream<User> getUserStream();
}

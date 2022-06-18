import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackmanthan_app/models/custom_exceptions.dart';
import 'package:hackmanthan_app/models/user.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  // Login using email and password
  Future<UserData> logInWithCredentials(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return user == null ? UserData.empty : UserData.fromUser(user);
    } on FirebaseAuthException catch (e) {
      // throw custom exceptions that can be handled in AppBloc
      print(e.code);
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundException();
        case 'wrong-password':
          throw WrongPasswordException();
        default:
          throw SomethingWentWrongException();
      }
    } catch (_) {
      throw SomethingWentWrongException();
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception catch (_) {
      // Throw custom exceptions that can be handled in AppBloc
      throw SignOutFailure();
    }
  }

  UserData get getUserData {
    User? user = _firebaseAuth.currentUser;
    return user == null ? UserData.empty : UserData.fromUser(user);
  }
}

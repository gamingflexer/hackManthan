import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackmanthan_app/models/user.dart';
import 'package:hackmanthan_app/shared/error_screen.dart';

class DatabaseRepository {
  final String uid;

  DatabaseRepository({required this.uid});

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Users Collection Reference
  // Reference allows for easy from and to operations
  CollectionReference<UserData> get usersRef =>
      db.collection('users').withConverter<UserData>(
            fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  // Get UserData from DB
  Future<UserData> get completeUserData async {
    try {
      UserData userDataNew = await usersRef
          .doc(uid)
          .get()
          .then((value) => value.data() ?? UserData.empty);
      return userDataNew;
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  // Update User in DB
  Future<void> updateUser(UserData userData) async {
    await usersRef.doc(uid).set(userData);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackmanthan_app/models/crime.dart';
import 'package:hackmanthan_app/models/prediction.dart';
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

  // Predictions Collection Reference
  // Reference allows for easy from and to operations
  CollectionReference<Prediction> get predictionsRef =>
      db.collection('predictions').withConverter<Prediction>(
            fromFirestore: (snapshot, _) =>
                Prediction.fromJson(snapshot.data()!),
            toFirestore: (prediction, _) => prediction.toJson(),
          );

  // Get Predictions from DB
  Future<List<Prediction>> getPredictions() async {
    try {
      List<Prediction> predictions = await predictionsRef
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
      return predictions;
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  // Crimes Collection Reference
  // Reference allows for easy from and to operations
  CollectionReference<Crime> get crimesRef =>
      db.collection('predictions').withConverter<Crime>(
            fromFirestore: (snapshot, _) => Crime.fromJson(snapshot.data()!),
            toFirestore: (crime, _) => crime.toJson(),
          );

  // Get Crimes from DB
  Future<List<Crime>> getCrimes() async {
    try {
      List<Crime> crimes = await crimesRef
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
      return crimes;
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  // Add Crimes from DB
  Future<void> addCrime(Crime crime) async {
    try {
      await crimesRef.add(crime);
      // TODO: Hit API after adding in Firestore
      // return res;
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  // Get Officers from DB
  Future<List<UserData>> getOfficers() async {
    try {
      List<UserData> officers = await usersRef
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
      return officers;
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }
}

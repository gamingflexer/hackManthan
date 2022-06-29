import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackmanthan_app/models/cluster.dart';
import 'package:hackmanthan_app/models/crime.dart';
import 'package:hackmanthan_app/models/alert.dart';
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
            fromFirestore: (snapshot, _) =>
                UserData.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (user, _) => user.toJson(),
          );

  // User Stream
  Stream<List<UserData>> getUserStream() {
    Stream<List<UserData>> res = usersRef
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
    return res;
  }

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

  // Alerts Collection Reference
  // Reference allows for easy from and to operations
  CollectionReference<Alert> get alertsRef =>
      db.collection('alerts').withConverter<Alert>(
            fromFirestore: (snapshot, _) =>
                Alert.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (alert, _) => alert.toJson(),
          );

  // Get alerts from DB
  Future<List<Alert>> getAlerts() async {
    try {
      List<Alert> alerts = await alertsRef
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
      return alerts;
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  // Alert Stream
  Stream<List<Alert>> getAlertStream() {
    Stream<List<Alert>> res = alertsRef
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
    return res;
  }

  // Crimes Collection Reference
  // Reference allows for easy from and to operations
  CollectionReference<Crime> get crimesRef =>
      db.collection('crimes').withConverter<Crime>(
            fromFirestore: (snapshot, _) =>
                Crime.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (crime, _) => crime.toJson(),
          );

  // Crime Stream
  Stream<List<Crime>> getCrimeStream() {
    Stream<List<Crime>> res = crimesRef
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
    return res;
  }

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

  // Cluster Collection Reference
  // Reference allows for easy from and to operations
  CollectionReference<Cluster> get clustersRef =>
      db.collection('clusters').withConverter<Cluster>(
            fromFirestore: (snapshot, _) =>
                Cluster.fromJson(snapshot.data()!, snapshot.id),
            toFirestore: (cluster, _) => cluster.toJson(),
          );

  // Get Clusters from DB
  Future<List<Cluster>> getClusters() async {
    try {
      List<Cluster> clusters = await clustersRef
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
      return clusters;
    } on Exception catch (_) {
      throw const SomethingWentWrong();
    }
  }

  // Cluster Stream
  Stream<List<Cluster>> getClusterStream() {
    Stream<List<Cluster>> res = clustersRef
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
    return res;
  }
}

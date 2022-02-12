import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:location/location.dart' as loc;
import 'dart:math' show cos, sqrt, asin;

final FirebaseAuth auth = FirebaseAuth.instance;
// HOW THIS WORKS

// Each new user who gets registered will get a new document under their user Id
// Each document will have many properties
// The document is linked to the specific user by using their user id

// HOW TO GET THE CURRENT USER ID
// final FirebaseAuth auth = FirebaseAuth.instance;
// final User user = auth.currentUser;
// final uid = user.uid;

dynamic prevlat = 0.0;
dynamic nextlat;
dynamic prevlon;
dynamic nextlon;
dynamic totaldistance = 0.0;
dynamic temp;
dynamic totalCo2 = 0.0;

final loc.Location location = loc.Location();
StreamSubscription<loc.LocationData>? _locationSubscription;

class DatabaseService {
  late String uid;
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  DatabaseService({this.uid = ''});

  // Collection Reference
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  // Adding data to the database
  Future addUserData(
    String name,
    String email,
    String password,
    dynamic latitude,
    dynamic longitude,
    dynamic acc,
    dynamic distance,
    dynamic totalCo2,
  ) async {
    return await collection.doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
      'latitude': 0.0,
      'longitude': 0.0,
      'acc': 0.0,
      'distance': 0.0,
      'co2_emission': 0.0,
    });
  }

  // data cancel located
  void canlocdata() async {
    _locationSubscription?.pause();
    setState() {
      _locationSubscription = null;
    }

    ;
  }

  // Start locating data
  void startLocDat() async {
    final loc.Location location = loc.Location();
    StreamSubscription<loc.LocationData>? _locationSubscription;
    _locationSubscription?.resume();
  }

  Future<String> getUserData() async {
    String name = '';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      DocumentSnapshot documentSnapshot = value;
      name = documentSnapshot['name'];
    });
    return name;
  }

  Future getCurrentLocation() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      DocumentSnapshot documentSnapshot = value;
      prevlat = documentSnapshot['latitude'];
      prevlon = documentSnapshot['longitude'];
    });
  }
}

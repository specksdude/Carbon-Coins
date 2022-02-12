import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart' as loc;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' show cos, sqrt, asin;

final loc.Location location = loc.Location();
StreamSubscription<loc.LocationData>? _locationSubscription;

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser!;
final uid = user.uid;

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

dynamic totalCo2 = 0.0;
dynamic totaldistance = 0.0;
dynamic temp = 0.0;
dynamic prevlat;
dynamic nextlat;
dynamic prevlon;
dynamic nextlon;
dynamic startlon;
dynamic startlat;
bool toggel = true;

class Test {
  void listenLocation() async {
    final loc.LocationData _locationResult = await location.getLocation();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      DocumentSnapshot documentSnapshot = value;
      prevlat = documentSnapshot['latitude'];
      prevlon = documentSnapshot['longitude'];
    });

    await FirebaseFirestore.instance.collection('users').doc(uid).update(
      {
        'latitude': _locationResult.latitude,
        'longitude': _locationResult.longitude,
        'acc': _locationResult.accuracy,
        'distance': totaldistance,
        'co2_emission': totalCo2,
      },
    );

    nextlat = await _locationResult.latitude;
    nextlon = await _locationResult.longitude;

    // print(' prev lat :  $prevlat');
    // print(' prev log :  $prevlon');
    // print(' next lat :  $nextlat');
    // print(' next log :  $nextlon');
    // print(' start lat :  $startlat');
    // print(' start log :  $startlon');

    if (toggel == true) {
      startlat = nextlat;
      startlon = nextlon;
      toggel = false;
    }

    temp = calculateDistance(startlat, startlon, nextlat, nextlon);

    if (temp >= 0.02 && temp < 0.1) {
      totaldistance += temp;
      dynamic safeEmissionofCo2 = 95;
      totalCo2 += (temp * safeEmissionofCo2) / 1000;
      startlat = nextlat;
      startlon = nextlon;
    }
    //print(' Total co2 send in d$totalCo2');
  }

  void canloc() async {
    //print("Location cancel located called");
    _locationSubscription?.pause();
    setState() {
      _locationSubscription = null;
    }

    ;
  }

  void startLoc() async {
    final loc.Location location = loc.Location();
    StreamSubscription<loc.LocationData>? _locationSubscription;
    _locationSubscription?.resume();
  }
}

// Algorithm for calculating the carbon coins
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser!;
final uid = user.uid;

dynamic prevlat;
dynamic nextlat;
dynamic prevlon;
dynamic nextlon;
double traveldis = 0.0;
double realtimec02 = 0.0;
double difference = 0.0;

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

void getUserData() {
  FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
    DocumentSnapshot documentSnapshot = value;
    traveldis = documentSnapshot['distance'];
    realtimec02 = documentSnapshot['co2_emission'];
  });
}

class Algorithm {
  double emission() {
    getUserData();
    // Data from the database
    // India
    const safeEmissionOfCo2 = 95;
    const avgKmPerDay = 35;

    // No round off digits allowed

    var co2EmissionInG = safeEmissionOfCo2 * avgKmPerDay;

    // Calculating 10% from the co2 emission
    var temp = co2EmissionInG / 10;
    var co2Emission = (co2EmissionInG - temp) / 1000;

    var totalkm = (co2Emission * 1000) / safeEmissionOfCo2;

    // print("Daily Co2 Emited Threshold = $co2Emission Kgs");

    // print("Total Km given to travel = $totalkm Km");
    return co2Emission;
  }

  double totaldistance() {
    getUserData();

    const safeEmissionOfCo2 = 95;
    const avgKmPerDay = 35;
    // No round off digits allowed
    var co2EmissionInG = safeEmissionOfCo2 * avgKmPerDay;
    // Calculating 10% from the co2 emission
    var temp = co2EmissionInG / 10;
    var co2Emission = (co2EmissionInG - temp) / 1000;
    var totalkm = (co2Emission * 1000) / safeEmissionOfCo2;
    return totalkm;
  }

  // Finding real-time co2 data which will come from database
  double realTime() {
    getUserData();

    // var disTraveled = 20; //change this for the distance travelled km
    // const safeEmissionofCo2 = 95; // kg

    // var totalCo2 = (disTraveled * safeEmissionofCo2) / 1000;

    // print('$totalCo2 kg co2 emitted by the user yet.');
    return realtimec02;
  }

  double distravel() {
    getUserData();

    // var disTraveled = totaldistance; //change this for the distance travelled
    // const safeEmissionofCo2 = 95;

    // var totalCo2 = (disTraveled * safeEmissionofCo2) / 1000;

    // print('$totalCo2 kg co2 emitted by the user yet.');
    return traveldis;
  }

// Our main function
// Calculates the coins based on the data we fetch from algoritm
  String coinCal() {
    getUserData();

    double thresholdCo2 = emission();
    // print('$thresholdCo2 thresholdCo2');
    double totalCo2 = realTime();
    // print('$totalCo2 totalco2 value');

    difference = thresholdCo2 - totalCo2;
    // print('Difference = $difference');
    if (difference > 0) {
      double valuetoround = (difference / 10);
      var coins =
          valuetoround.toStringAsFixed(3); // decial roundedoff to 4 places
      return coins;
      // Convert the return type to double
    } else if (difference < 0) {
      return "Crossed the Threshold";
    }
    return "coins";
  }
}

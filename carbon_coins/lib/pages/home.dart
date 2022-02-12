import 'package:carbon_coins/Backend/algorithm.dart';
import 'package:carbon_coins/Backend/location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'navigation_drawer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:carbon_coins/Backend/database.dart';
import 'package:location/location.dart' as loc;
import 'dart:async';
import 'package:toggle_switch/toggle_switch.dart';

var firstLetter;
final user = FirebaseAuth.instance.currentUser;
StreamSubscription<loc.LocationData>? _locationSubscription;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

var callLocate = Test().listenLocation();
bool toggleswitch = false;
int count = 0;
int initialIndex = 5;

Timer mytimer = Timer.periodic(Duration(seconds: 3), (timer) {
  if (toggleswitch == true) {
    Test().listenLocation();
  }
});

dynamic realTime = 0;
dynamic coins = 0;
dynamic disTraveled = 0;
dynamic threshold = 0;
dynamic totaldis = 0;
dynamic percentagedis = 0;
dynamic percentageCo2 = 0;

var the_algo = Algorithm();

double percheck(dynamic numer, dynamic deno) {
  if ((numer / deno) < 1) {
    return (numer / deno);
  } else {
    return 1;
  }
}

dynamic printcoins;

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user_data = auth.currentUser!;
    final uid = user_data.uid;
    realTime = the_algo.realTime().toPrecision(2); // real time co2
    coins = the_algo.coinCal();
    if (coins == 'Crossed the Threshold') {
      printcoins = "You have Crossed \n the Threshold";
    } else {
      printcoins = '$coins cc';
    }
    disTraveled = the_algo.distravel().toPrecision(3); //real time distance
    threshold = the_algo.emission(); // the threshold of co2
    totaldis = the_algo.totaldistance(); // the threshold of dis
    percentageCo2 = percheck(realTime, threshold);

    percentagedis = percheck(disTraveled, totaldis);

    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 640),
        minTextAdapt: true,
        orientation: Orientation.portrait);

    DatabaseService(uid: uid).getUserData().then((value) async {
      var temp = value[0];
      setState(() {
        firstLetter = temp.toUpperCase();
      });
    });

    return Scaffold(
      backgroundColor: const Color(0xFF4eba6b),
      drawer: NavigationDrawer(),
      body: Builder(
        builder: (context) => SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF4eba6b),
                Color(0xFF30abc9),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
            )),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.menu),
                      tooltip: 'Open menu',
                      iconSize: 30.h,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    SizedBox(height: 20.h, width: 255.w),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.w, 8.h, 0.w, 0.h),
                      child: CircleAvatar(
                        child: Text(
                          firstLetter.toString(),
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        radius: 25.r,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      child: CircularPercentIndicator(
                        radius: 100.0.r,
                        lineWidth: 8.0.w,
                        animation: true,
                        percent: percentageCo2,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.blue,
                        backgroundColor: Colors.greenAccent,
                        center: CircleAvatar(
                          radius: 80.r,
                          child: Container(
                            width: 160.w,
                            height: 160.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xCC51b6db),
                                    Color(0xFF3972bd),
                                  ],
                                  begin: FractionalOffset(0.0, 0.0),
                                  end: FractionalOffset(0.0, 0.9),
                                )),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 35.h, horizontal: 10.w),
                              child: Text(
                                '$realTime \nKG',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontFamily: 'NexaBold',
                                    fontSize: 35.sp),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child: Container(
                    height: 400.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: <Color>[
                          Color(0xCC51b6db),
                          Color(0xDD3972bd),
                        ],
                        begin: FractionalOffset(0.0, 1.3),
                        end: FractionalOffset(0.0, 0.0),
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0.r),
                        topLeft: Radius.circular(40.0.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 0.h,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(50.w, 20.h, 50.w, 0.h),
                          child: Container(
                            height: 80.h,
                            width: double.infinity,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    "Km Travelled",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'NexaBold',
                                        fontSize: 20.sp),
                                  ),
                                  LinearPercentIndicator(
                                    barRadius: Radius.circular(15.r),
                                    animation: true,
                                    lineHeight: 28.0,
                                    animationDuration: 400,
                                    percent: percentagedis,
                                    center: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 3.h, 0, 0),
                                      child: Text('$disTraveled / $totaldis km',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'NexaBold',
                                              fontSize: 15.h)),
                                    ),
                                    progressColor: Colors.blue[400],
                                    backgroundColor: const Color(0xFF47c98a),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 30.r,
                                    offset: const Offset(2, 2))
                              ],
                              borderRadius: BorderRadius.circular(20.0.r),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1.0.w),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.5),
                                  Colors.white.withOpacity(0.1),
                                ],
                                stops: const [
                                  0.0,
                                  1.9,
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.h,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(50.w, 20.h, 50.w, 0.h),
                          child: Container(
                            height: 80.h,
                            width: double.infinity,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.h,
                                ),
                                Center(
                                  child: Text(
                                    'Co2 Emitted',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'NexaBold',
                                        fontSize: 20.h),
                                  ),
                                ),
                                LinearPercentIndicator(
                                  barRadius: Radius.circular(15.r),
                                  animation: true,
                                  lineHeight: 28.0,
                                  animationDuration: 400,
                                  percent: percentageCo2,
                                  center: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 3.h, 0, 0),
                                    child: Text('$realTime / $threshold kg',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'NexaBold',
                                            fontSize: 15.sp)),
                                  ),
                                  progressColor: Colors.blue[400],
                                  backgroundColor: const Color(0xFF47c98a),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 30,
                                  offset: const Offset(2, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(20.0.r),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1.0.w),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.5),
                                  Colors.white.withOpacity(0.1)
                                ],
                                stops: const [
                                  0.0,
                                  1.9,
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.h,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(50.w, 20.h, 50.w, 0.h),
                          child: Container(
                            height: 80.h,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                '$printcoins',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'NexaBold',
                                    fontSize: 20.h),
                              ),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 30.r,
                                  offset: const Offset(2, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20.0.r),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.2.r),
                                  width: 1.0.w),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.5),
                                  Colors.white.withOpacity(0.1),
                                ],
                                stops: const [
                                  0.0,
                                  1.9,
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ToggleSwitch(
                              minWidth: 150.0.w,
                              minHeight: 30.h,
                              cornerRadius: 20.0.r,
                              activeBgColors: [
                                [Color(0xFF36bf6a)],
                                [Color(0xFF36bf6a)]
                              ],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Color(0xCC3972bd),
                              inactiveFgColor: Colors.white,
                              initialLabelIndex: initialIndex,
                              totalSwitches: 2,
                              labels: ['Start Tracking', 'Stop Tracking'],
                              customTextStyles: [
                                TextStyle(
                                  fontSize: 18.0.sp,
                                  height: 1.3.sp,
                                  color: Colors.white,
                                  fontFamily: 'NexaBold',
                                ),
                                TextStyle(
                                  fontSize: 18.0.sp,
                                  height: 1.3.sp,
                                  color: Colors.white,
                                  fontFamily: 'NexaBold',
                                )
                              ],
                              radiusStyle: true,
                              onToggle: (index) {
                                if (index == 0) {
                                  toggleswitch = true;
                                  final loc.Location location = loc.Location();
                                  StreamSubscription<loc.LocationData>?
                                      _locationSubscription;
                                  startTracking();
                                  DatabaseService(uid: uid).startLocDat();
                                  Test().startLoc();
                                  mytimer.isActive;
                                } else if (index == 1) {
                                  toggleswitch = false;
                                  _locationSubscription?.pause();
                                  DatabaseService(uid: uid).canlocdata();
                                  Test().canloc();
                                }
                                setState(() {
                                  initialIndex = index!;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void startTracking() {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
  _locationSubscription?.resume();
  _locationSubscription = location.onLocationChanged.handleError((onError) {
    print(onError);
    _locationSubscription?.cancel();
  }).listen((loc.LocationData currentlocation) async {});
}

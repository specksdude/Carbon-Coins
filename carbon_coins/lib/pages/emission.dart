import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'navigation_drawer.dart';

class Emission extends StatefulWidget {
  const Emission({Key? key}) : super(key: key);

  @override
  _EmissionState createState() => _EmissionState();
}

class _EmissionState extends State<Emission> {
  List emmisionLog = [
    "20kg \n 12/20/21",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22",
    "20 kg \n 12/20/21",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22",
    "25 kg \n 12/20/22"
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 640),
        minTextAdapt: true,
        orientation: Orientation.portrait);

    return Scaffold(
      backgroundColor: const Color(0xFF548bd6),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Emission Log",
            style: TextStyle(
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: const Color(0xFF3db87c),
        elevation: 0.0,
      ),
      drawer: const NavigationDrawer(),
      body: Builder(
        builder: (context) => SafeArea(
          child: LogListing(log: emmisionLog),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget LogListing({required List log}) {
  return ListView(
    children: [
      ...log
          .map<Widget>(
            (data) => Padding(
              padding: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50.h,
                    child: Center(
                      child: Text(
                        data,
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontFamily: 'NexaBold', fontSize: 20.h),
                      ),
                    ),
                  ),
                  const Divider(thickness: 2, color: Colors.white),
                ],
              ),
            ),
          )
          .toList(),
      SizedBox(height: 10.h),
    ],
  );
}

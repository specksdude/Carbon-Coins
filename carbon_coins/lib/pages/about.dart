// ignore: file_names
// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carbon_coins/pages/navigation_drawer.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
      backgroundColor: const Color(0xFF3f5dbf),
      drawer: NavigationDrawer(),
      body: Builder(
        builder: (context) => SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: 640.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xEE465094),
                    Color(0xFF3f5dbf),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          color: Colors.white,
                          icon: const Icon(Icons.menu),
                          iconSize: 30.h,
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ],
                    ),
                    // SizedBox(height: 5.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/Logo.png'),
                          width: 175.w,
                          height: 175.h,
                        ),
                        // SizedBox(height: 5.h),
                        Text(
                          'Carbon Coins',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NexaBold',
                              fontSize: 40.sp),
                        ),
                        Text(
                          'v0.3',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.3.h,
                              color: Colors.white,
                              fontFamily: 'NexaBold',
                              fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                            'Carbon Coins is a mobile application that aids in the reduction of carbon emissions from vehicles. Users can create an account and keep track of how much carbon their vehicle emits while on the road. This app also gives out coins to those who emit the least amount of carbon. \n Many features that will assist in carbon reduction are still to come.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'NexaBold',
                                fontSize: 17.sp),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        Text(
                          'Contact Us',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NexaBold',
                              fontSize: 25.sp),
                        ),
                        Text(
                          'aryansingh6011@gmail.com',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'NexaBold',
                              fontSize: 20.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

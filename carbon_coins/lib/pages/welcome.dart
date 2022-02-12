// ignore: file_names
// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
      backgroundColor: const Color(0xFF4eba6b),
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/images/welcome.jpg"),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.h),
              Image(
                image: AssetImage('assets/images/Logo.png'),
                width: 200.w,
                height: 200.h,
              ),
              SizedBox(height: 280.h),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0.r))),
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                padding: const EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.0.r)),
                    gradient: LinearGradient(
                      colors: const <Color>[
                        Color(0xEE53c4e7),
                        Color(0xFF175db8),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(30.w, 20.h, 25.w, 10.h),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontFamily: 'NexaBold',
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 2.h, 0, 7.h),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 35.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

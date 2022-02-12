// ignore_for_file: deprecated_member_use

import 'package:carbon_coins/Backend/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var name;
  var email;
  var pass;
  String error = '';
  var confirmpass;

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _confirmpass = TextEditingController();

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
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color(0xFF4eba6b),
                Color(0xFF30abc9),
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          reverse: true,
          child: SafeArea(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Second Curved Box
                  SizedBox(height: 80.h),
                  SizedBox(
                    height: 350.h,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.r)),
                        gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xCC000000),
                            Color(0xBB0f0c0c),
                          ],
                        ),
                      ),
                      margin: EdgeInsets.fromLTRB(30.w, 0.h, 30.w, 0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 42.5.h),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                            child: TextField(
                              controller: _name,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.r)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.r),
                                  borderSide: BorderSide(
                                      color: const Color(0xFF367346),
                                      width: 2.5.w),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 14.h),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Name",
                                hintStyle: TextStyle(
                                  fontFamily: 'NexaBold',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                            child: TextField(
                              controller: _email,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.r)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.r),
                                  borderSide: BorderSide(
                                      color: const Color(0xFF367346),
                                      width: 2.5.w),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 14.h),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  fontFamily: 'NexaBold',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                            child: TextField(
                              controller: _pass,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.r)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.r),
                                  borderSide: BorderSide(
                                      color: const Color(0xFF367346),
                                      width: 2.5.w),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 14.h),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  fontFamily: 'NexaBold',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                            child: TextField(
                              controller: _confirmpass,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40.r)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40.r),
                                  borderSide: BorderSide(
                                      color: const Color(0xFF367346),
                                      width: 2.5.w),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 14.h),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(
                                  fontFamily: 'NexaBold',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(40.0.r))),
                    // color: Colors.amber,
                    onPressed: () {
                      name = _name.text;
                      email = _email.text;
                      pass = _pass.text;
                      confirmpass = _confirmpass.text;
                      print(name);
                      print(email);
                      print(pass);
                      print(confirmpass);
                      if ((pass == confirmpass && pass != "") &&
                          (name != "" && email != "")) {
                        signUp();
                      } else if ((name == "" && email == "")) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text("Please enter all the details"),
                            );
                          },
                        );
                      } else if (pass == "") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text("Please enter The password"),
                            );
                          },
                        );
                      } else if (name == "") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text("Please Enter Name"),
                            );
                          },
                        );
                      } else if (email == "") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text("Please Enter your Email"),
                            );
                          },
                        );
                      } else if (pass != confirmpass) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              content: Text(
                                  "Password and confirm password is different"),
                            );
                          },
                        );
                      }
                    },
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.0.r)),
                        gradient: const LinearGradient(
                          colors: <Color>[
                            Color(0xEE53c4e7),
                            Color(0xFF175db8),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(40.w, 20.h, 40.w, 15.h),
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          fontSize: 25.sp,
                          fontFamily: 'NexaBold',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0.r))),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      padding: EdgeInsets.all(0.h),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(40.0.r)),
                          gradient: const LinearGradient(
                            colors: <Color>[
                              Color(0xEE53c4e7),
                              Color(0xFF175db8),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: 'NexaBold',
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(), password: _pass.text.trim());
      User user = auth.currentUser!;
      final uid = user.uid;
      await DatabaseService(uid: uid).addUserData(_name.text.trim(),
          _email.text.trim(), _pass.text.trim(), 0, 0, 0, 0, 0);
      await Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      setState(() {
        error = 'Please chek the email and the password';
      });
    }
  }
}

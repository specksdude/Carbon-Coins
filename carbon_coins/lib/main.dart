import 'package:carbon_coins/Backend/wrapper.dart';
import 'package:carbon_coins/pages/coming_soon.dart';
import 'package:flutter/material.dart';
import 'package:carbon_coins/pages/login.dart';
import 'package:carbon_coins/pages/home.dart';
import 'package:carbon_coins/pages/welcome.dart';
import 'package:carbon_coins/pages/signin.dart';
import 'package:carbon_coins/pages/emission.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Routes());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Routes extends StatelessWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: {
        '/': (context) => const Welcome(),
        '/wrapper': (context) => const Wrapper(),
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/home': (context) => const Home(),
        '/emission': (context) => const Emission(),
        '/comingsoon': (context) => const Comingsoon(),
      },
    );
  }
}

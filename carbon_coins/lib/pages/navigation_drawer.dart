import 'package:carbon_coins/pages/about.dart';
import 'package:carbon_coins/pages/home.dart';
import 'package:carbon_coins/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carbon_coins/pages/coming_soon.dart';
import 'package:carbon_coins/pages/emission.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carbon_coins/Backend/database.dart';

const padding = EdgeInsets.symmetric(horizontal: 20);
var name = '';
final user = FirebaseAuth.instance.currentUser!;

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    final User user_data = auth.currentUser!;
    final uid = user_data.uid;

    DatabaseService(uid: uid).getUserData().then((value) {
      name = value;
    });

    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(360, 640),
        minTextAdapt: true,
        orientation: Orientation.portrait);

    return Drawer(
      child: Material(
        color: const Color(0xFF3972bd),
        child: ListView(
          // To have a space around each item
          padding: padding,
          children: <Widget>[
            SizedBox(height: 20.h),
            buildHeader(name: name),
            SizedBox(height: 20.h),
            buildMenuItem(
              text: 'Home',
              icon: Icons.home_outlined,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: 'Emission',
              icon: Icons.cloud_outlined,
              onClicked: () => selectedItem(context, 1),
            ),
            SizedBox(height: 5.h),
            const Divider(color: Colors.white),
            SizedBox(height: 5.h),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings_outlined,
              onClicked: () => selectedItem(context, 2),
            ),
            SizedBox(height: 10.h),
            buildMenuItem(
              text: 'About',
              icon: Icons.info_outlined,
              onClicked: () => selectedItem(context, 4),
            ),
            SizedBox(height: 10.h),
            buildMenuItem(
              text: 'Log Out',
              icon: Icons.logout_outlined,
              onClicked: () => selectedItem(context, 3),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for each item in the drawer
Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: Colors.white,
    ),
    title: Text(
      text,
      style: const TextStyle(
        height: 2,
        fontFamily: 'NexaBold',
        fontSize: 20,
        color: Colors.white,
      ),
    ),
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();
  switch (index) {
    case 0:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
      break;
    case 1:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Emission(),
        ),
      );
      break;
    case 2:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Comingsoon(),
        ),
      );
      break;
    case 3:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const Welcome(),
        ),
      );
      FirebaseAuth.instance.signOut();
      break;
    case 4:
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const About(),
        ),
      );
      break;
  }
}

Widget buildHeader({required String name}) => InkWell(
      child: Container(
        padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFF4eba6b),
            ),
            SizedBox(
              height: 15.h,
            ),
            Column(
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

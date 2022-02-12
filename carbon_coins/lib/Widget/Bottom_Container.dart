import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  final Widget child;

  BottomContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: const BoxDecoration(
            color: Color(0xFF3D90DD),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            )),
        child: child,
      ),
    );
  }
}

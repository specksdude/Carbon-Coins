import 'package:flutter/material.dart';

void alertBox(String message, context) {
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
          // content: Text(message),
          );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastTemplate {
  final String x = "x";
  show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black.withOpacity(0.6),
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}

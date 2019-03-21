import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 吐司
class Swift {
  static void toast(String content) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red[300],
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

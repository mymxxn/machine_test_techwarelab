import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarServices {
  static errorSnackbar(String message) {
    print(message);
    Get.snackbar('Warning', message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        // borderColor: Colors.red,
        // borderWidth: 1,
        duration: Duration(seconds: 2),
        icon: Icon(Icons.error, color: Colors.white));
  }

  static void successSnackbar(String message) {
    Get.snackbar('Success', message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        borderRadius: 10,
        margin: EdgeInsets.all(10),
        // borderColor: Colors.green,
        // borderWidth: 1,
        duration: Duration(seconds: 2),
        icon: Icon(Icons.check, color: Colors.white));
  }
}

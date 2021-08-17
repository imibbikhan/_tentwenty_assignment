import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Utils {
  static double getScreenFullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static void displayMessage(BuildContext context, String message) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String extracNames(dynamic genres) {
    print(genres);
    String names = "";
    for (Map<String, dynamic> genre in genres) {
      names = names + genre["name"] + ", ";
    }
    return names.substring(0, names.length - 2);
  }

  static Future<bool> isBooked(int id) async {
    var pref = await SharedPreferences.getInstance();
    return pref.getInt(id.toString()) != null;
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ten_twenty_movie/utils/util.dart';

class HttpRequest {
  static Future<dynamic?> makeRequest(BuildContext context, String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      Utils.displayMessage(context, "Error while fetching details");
    }
  }
}

library olw_core;

import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:olw_mobile_core/connection/WebSocketConnection.dart';

class OneLiveWeb {
  Map? settings;


  Future<Map> getJsonFromServer(String inUrl) async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  void initialize() async {
    await loadAppSettings();
    Get.put<LiveWebConnection>(LiveWebConnection());
    Get.put<OneLiveWeb>(this);

  }

  Future<Map?> loadAppSettings() async {
    if (settings == null) {
      String json = await rootBundle.loadString("system/appsettings.json");
      print("loaded ${json}");
      settings = jsonDecode(json);
    }
    return settings;
  }
}

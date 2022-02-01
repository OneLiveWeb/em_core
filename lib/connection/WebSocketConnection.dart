import 'dart:convert';

import 'package:get/get.dart';
import 'package:olw_mobile_core/olw_mobile_core.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LiveWebConnection {
  var olw = Get.find<OneLiveWeb>();

  IOWebSocketChannel? channel;

  void connect() {
    if (channel == null) {
      channel = IOWebSocketChannel.connect(Uri.parse(getConnectionUrl()));
      printServerMessages(channel!.stream);
    }
  }

  void sendServerCommand(String url, Map params) {
    if(channel == null){
      connect();
    }
    channel!.sink.add(jsonEncode(params));

  }

  String getConnectionUrl() {


    var url = "${olw.settings!['websocket_config']?['websocket_dev_url']}";
    return url;
  }

  // void sendLocationInformation(double lat, double long) async {
  //
  //   Map testmap = {
  //     "context": "vessels.self",
  //     "updates": [
  //       {
  //         "values": [
  //           {
  //             "path": "navigation.position",
  //             "value": {"altitude": 0, "latitude": lat, "longitude": long}
  //           }
  //         ]
  //       }
  //     ]
  //   };
  //   print(jsonEncode(testmap));
  //
  //   channel.sink.add(jsonEncode(testmap));
  // }


  Future<dynamic> printServerMessages(Stream<dynamic> stream) async {
    await for (var value in stream) {
      print(value);
    }
  }
}

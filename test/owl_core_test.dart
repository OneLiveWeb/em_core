import 'package:flutter_test/flutter_test.dart';
import 'package:olw_mobile_core/connection/WebSocketConnection.dart';
import 'package:olw_mobile_core/olw_mobile_core.dart';
import 'package:get/get.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); //Nasty!
  final olw = OneLiveWeb();
  Get.put<OneLiveWeb>(olw);
  olw.initialize();

  test('Load Settings', () async {


    Map? settings =  await olw.loadAppSettings();
    expect(settings!.isNotEmpty, true);

  });


  test('Connect Websocket', () async {


    var connection = Get.find<LiveWebConnection>(); //from initialize()
    Map request = {
      "runpath":"/some/run/path",
      "userid":"123",
    };
    connection.sendServerCommand("/somepath/", request);




  });
}

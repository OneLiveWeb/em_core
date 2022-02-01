import 'package:xml/xml.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class DataManager{
  PropertyDetailsArchive archive = PropertyDetailsArchive();



}
class PropertyDetailsArchive {

  Future<List<PropertyDetail>>  loadPropertyDetails(String inSearchType) async{
    String xml = await rootBundle.loadString("system/fields/${inSearchType}.xml");
    final document = XmlDocument.parse(xml);
    List<PropertyDetail> details = [];
    document.getElement("properties")!.childElements.forEach((detailxml) {
      PropertyDetail detail = PropertyDetail();
      detail.id = detailxml.getAttribute("id");
      detail.viewtype = detailxml.getAttribute("viewtype") ?? "default";
      detail.name = detailxml.getAttribute("name") ?? detailxml.text ;
      detail.editable = detailxml.getAttribute("editable")!.toLowerCase() == 'true';
      details.add(detail);
      print("Details dsafasdares ${detail}");
    });
    print(details);
    return details;

  }



}



class PropertyDetail  {

  String viewtype = "default";
  String name ="default";
  String? id;
  bool editable = true;
  @override
  String toString() {
    // TODO: implement toString
    return "${name}";
  }

}
import 'package:flutter/services.dart' show rootBundle;
import 'package:greenkart/model/GeenKartModel.dart';

class JsonManager{
  Future getJson()async{
    var data = await rootBundle.loadString('assets/json/GreenKart.json');

    return greenKartModelFromJson(data);
  }
}
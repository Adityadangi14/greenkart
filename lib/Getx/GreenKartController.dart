import 'package:get/get.dart';
import 'package:greenkart/jsonManager/jsonManager.dart';
import 'package:greenkart/model/GeenKartModel.dart';

class GreenKartController extends GetxController {
  var loading = false.obs;

  JsonManager jsonManager = JsonManager();

  List<GreenKartModel>? json;

  List<GreenKartModel> toRemove = [];

  Map filterState = {'Premium': false, 'Tamilnadu': false};

  Future getGreenKartJson() async {
    loading(true);
    json = await jsonManager.getJson();
    loading(false);
    update();
  }

  Future<void> filterManager(String category, bool? value) async {
    if (value!) {
      applyFilter(category);
    }

    if(value== false){
      removeFilter(category);
    }
    filterState[category] = value;

    update();
  }

  void applyFilter(String category) {
    List toRemove = [];
    if (json != null) {
      for (var i in json!) {
        if (i.pCategory != category) {
          toRemove.add(i);
        }
      }
      json!.removeWhere((e) => toRemove.contains(e));
    }
    toRemove = [];
  }

  void removeFilter(String category) async {
    List<GreenKartModel> toAdd = [];

    if (json != null) {
      List<GreenKartModel> data = await jsonManager.getJson();

      for (var i in data) {
        if (i.pCategory != category) {
          toAdd.add(i);
        }
      }
      json!.addAll(toAdd);
    }
    toAdd = [];
  }
}

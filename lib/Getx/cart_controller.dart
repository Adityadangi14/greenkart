import 'package:get/get.dart';
import 'package:greenkart/jsonManager/jsonManager.dart';

import '../model/GeenKartModel.dart';

class CartController extends GetxController {
  Map<GreenKartModel, String> cart = {};

  JsonManager jsonManager = JsonManager();
  Future<bool> addItem(String qty, int pId) async {
    GreenKartModel item = await fetchItem(pId);
    cart[item] = qty;
    update();
    return true;
  }

  fetchItem(int p_Id) async {
    List<GreenKartModel> data = await jsonManager.getJson();

    for (var i in data) {
      if (i.pId == p_Id) {
        return i;
      }
    }
  }
}

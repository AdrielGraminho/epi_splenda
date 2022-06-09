import 'package:flutter/material.dart';
import 'package:splenda_epi/models/item.dart';
import 'package:splenda_epi/services/item_service.dart';

class ItemProvider extends ChangeNotifier {
  List<Item> itemList = [];
  Future<void> findAllItems(BuildContext context) async {
    try {
      itemList = await ItemService().findAllItems(context);
    } catch (e) {
      itemList = [];
    }
    notifyListeners();
  }
}

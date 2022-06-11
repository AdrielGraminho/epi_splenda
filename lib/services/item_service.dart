import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splenda_epi/models/item.dart';

import '../shared/data/store.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class ItemService {
  Future<List<Item>> findAllItems(BuildContext context) async {
    List<Item> itemList = [];

    String _uri = Constants.baseUrl + 'item/all';

    final token = await Store.getToken(context);

    final response = await http.get(
      Uri.parse(_uri),
      headers: {'Authorization': 'Bearer $token'},
    );
    List data = json.decode(response.body);

    for (var element in data) {
      itemList.add(Item(
        idItem: element['idItem'],
        description: element['description'],
        durability: element['durability'],
      ));
    }

    return Future.value(itemList);
  }

  Future<List<Item>> findByEmployeeId(
      BuildContext context, int idEmployee) async {
    List<Item> itemList = [];

    String _uri = Constants.baseUrl + 'item?idEmployee=$idEmployee';

    final token = await Store.getToken(context);

    final response = await http.get(
      Uri.parse(_uri),
      headers: {'Authorization': 'Bearer $token'},
    );
    List data = json.decode(response.body);

    for (var element in data) {
      itemList.add(Item(
          idItem: element['idItem'],
          description: element['description'],
          durability: element['durability'],
          idExit: element['idExit']));
    }

    return Future.value(itemList);
  }
}

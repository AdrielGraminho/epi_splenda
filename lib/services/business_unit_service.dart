import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splenda_epi/models/business_unit.dart';

import '../shared/data/store.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class BusinessUnitService {
  Future<List<BusinessUnit>> getBusinessUnit(BuildContext context) async {
    List<BusinessUnit> businessUnitList = [];

    String _uri = Constants.baseUrl + 'business-unit';

    final token = await Store.getToken(context);

    final response = await http.get(
      Uri.parse(_uri),
      headers: {'Authorization': 'Bearer $token'},
    );
    List data = json.decode(response.body);

    data.forEach((element) {
      businessUnitList.add(BusinessUnit(
        idBusinessUnit: element['idBusinessUnit'],
        idCompany: element['idCompany'],
        code: element['code'],
        description: element['description'],
        codeMetadados: element['codeMetadados'],
      ));
    });

    return Future.value(businessUnitList);
  }
}

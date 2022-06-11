import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splenda_epi/models/audit_item.dart';
import 'package:splenda_epi/models/audit_type.dart';
import 'package:http/http.dart' as http;

import '../shared/data/store.dart';
import '../utils/constants.dart';

class AuditService {
  Future<List<AuditType>> findAllAuditType(BuildContext context) async {
    List<AuditType> auditTypeList = [];

    String _uri = Constants.baseUrl + 'audit';

    final token = await Store.getToken(context);

    final response = await http.get(
      Uri.parse(_uri),
      headers: {'Authorization': 'Bearer $token'},
    );

    List data = json.decode(response.body);

    for (var element in data) {
      List<AuditItem> auditItemList = [];
      List dataItem = element['auditItemList'];

      for (var item in dataItem) {
        auditItemList.add(AuditItem(
            description: item['description'],
            idAuditItem: item['idAuditItem']));
      }
      auditTypeList.add(AuditType(
        idAuditType: element['idAuditType'],
        description: element['description'],
        auditItemList: auditItemList,
      ));
    }

    return Future.value(auditTypeList);
  }
}

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

    List data = json.decode(utf8.decode(response.bodyBytes));

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

  Future<void> send(BuildContext context, int idBusinessUnit, int idItem,
      String qualifyingFactorType) async {
    String _uri = Constants.baseUrl + 'audited';

    final token = await Store.getToken(context);

    final response = await http.post(
      Uri.parse(_uri),
      body: jsonEncode({
        'itemId': idItem,
        'businessUnitId': idBusinessUnit,
        'qualifyingFactorType': qualifyingFactorType
      }),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode.toString() != '200') {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Erro ao enviar dados"),
                content: const Text(
                    "Por favor, entre em contato com os administradores"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Fechar'))
                ],
              ));
    }
    return Future.value();
  }
}

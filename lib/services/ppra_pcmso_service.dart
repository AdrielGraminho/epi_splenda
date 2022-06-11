import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splenda_epi/models/ppra_pcmso.dart';
import 'package:splenda_epi/shared/data/store.dart';
import 'package:splenda_epi/utils/constants.dart';
import 'package:http/http.dart' as http;

class PpraPcmsoService {
  Future<List<PpraPcmso>> findPpraPcmsoByBusinessUnit(
      BuildContext context, int idBusinessUnit) async {
    List<PpraPcmso> ppraPcmsoList = [];

    String _uri =
        Constants.baseUrl + 'ppra-pcmso?idBusinessUnit=$idBusinessUnit';
    final token = await Store.getToken(context);

    final response = await http.get(
      Uri.parse(_uri),
      headers: {'Authorization': 'Bearer $token'},
    );
    List data = json.decode(response.body);

    for (var element in data) {
      ppraPcmsoList.add(PpraPcmso(
        idPpraPcmso: element['idPpraPcmso'],
        expirationDate: DateTime.parse(element['expirationDate'].toString()),
        exchangeDate: DateTime.parse(element['exchangeDate'].toString()),
        ppraAndPcmsoType: element['ppraAndPcmsoType'],
      ));
    }

    return Future.value(ppraPcmsoList);
  }
}

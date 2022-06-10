import 'dart:convert';

import 'package:flutter/material.dart';

import '../shared/data/store.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class ReceivedService {
  Future<void> send(
      BuildContext context, String? idEmploye, String? idItem) async {
    String _uri = Constants.baseUrl + 'exit';

    final token = await Store.getToken(context);

    final response = await http.post(
      Uri.parse(_uri),
      body: jsonEncode({'idItem': idItem, 'idEmployee': idEmploye}),
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

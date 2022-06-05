import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splenda_epi/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../screens/calendar_screen.dart';

class LoginService {
  final Uri _url = Uri.parse(Constants.baseUrl + 'auth/signin');

  Future<void> authenticate(
      String userName, String password, BuildContext context) async {
    final response = await http.post(
      _url,
      body: jsonEncode({'username': userName.trim(), 'password': password}),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    if (response.statusCode.toString() == '401') {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Erro ao autenticar"),
                content: const Text("Verifique seu usuário e senha, por favor"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Fechar'))
                ],
              ));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CalendarScreen()));
    }
  }
}

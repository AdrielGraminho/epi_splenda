import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splenda_epi/models/employee.dart';

import '../shared/data/store.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  Future<dynamic> findByCpf(BuildContext context, String cpf) async {
    String _uri = Constants.baseUrl + 'employee?cpf=$cpf';

    final token = await Store.getToken(context);

    final response = await http.get(
      Uri.parse(_uri),
      headers: {'Authorization': 'Bearer $token'},
    );

    dynamic data = json.decode(response.body);

    if (response.statusCode == 500) {
      return Future.value();
    }

    Employee employee = Employee(
      id: data['id'],
      name: data['name'],
      cpf: data['cpf'],
    );

    return Future.value(employee);
  }
}

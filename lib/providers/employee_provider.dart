import 'package:flutter/material.dart';
import 'package:splenda_epi/models/employee.dart';
import 'package:splenda_epi/services/employee_service.dart';

class EmployeeProvider extends ChangeNotifier {
  String _name = '';
  int? _idEmployee;
  int? get idEmployee => _idEmployee;
  String get name => _name;
  Future<void> findEmployeeByCpf(String cpf, BuildContext context) async {
    var response = await EmployeeService().findByCpf(context, cpf);

    if (response?.name != null) {
      Employee employee = response;
      _name = employee.name!;
      _idEmployee = employee.id;
    } else {
      _name = '';
      _idEmployee = null;
    }

    notifyListeners();
    Future.value();
  }
}

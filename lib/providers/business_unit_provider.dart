import 'package:flutter/material.dart';
import 'package:splenda_epi/models/business_unit.dart';
import 'package:splenda_epi/services/business_unit_service.dart';

class BusinessUnitProvider extends ChangeNotifier {
  List<BusinessUnit> _businessUnitList = [];

  List<BusinessUnit> get businessUnit => _businessUnitList;

  Future<void> getBusinessUnitByPermission(BuildContext context) async {
    _businessUnitList.clear();
    _businessUnitList =
        await Future.value(BusinessUnitService().getBusinessUnit(context));
    notifyListeners();

    return Future.value();
  }
}

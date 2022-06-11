import 'package:flutter/material.dart';
import 'package:splenda_epi/models/audit_type.dart';
import 'package:splenda_epi/services/audit_service.dart';

class AuditProvider extends ChangeNotifier {
  List<AuditType> _auditTypeList = [];
  List<AuditType> get auditTypeList => _auditTypeList;

  Future<void> findAllAuditType(BuildContext context) async {
    _auditTypeList = await AuditService().findAllAuditType(context);

    notifyListeners();

    Future.value();
  }
}

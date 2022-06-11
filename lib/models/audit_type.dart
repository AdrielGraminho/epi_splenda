import 'package:splenda_epi/models/audit_item.dart';

class AuditType {
  final int idAuditType;
  final String description;
  final List<AuditItem> auditItemList;

  AuditType({
    required this.idAuditType,
    required this.description,
    required this.auditItemList,
  });
}

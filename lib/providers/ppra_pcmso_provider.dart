import 'package:flutter/material.dart';
import 'package:splenda_epi/models/ppra_pcmso.dart';
import 'package:splenda_epi/services/ppra_pcmso_service.dart';

class PpraPcmsoProvider extends ChangeNotifier {
  List<PpraPcmso> _ppraPcmsoList = [];
  List<PpraPcmso> get ppraPcmsoList => _ppraPcmsoList;

  Future<void> findPpraPcmsoByBusinessUnit(
      BuildContext context, int idBusinessUnit) async {
    try {
      _ppraPcmsoList = await PpraPcmsoService()
          .findPpraPcmsoByBusinessUnit(context, idBusinessUnit);
    } catch (e) {
      _ppraPcmsoList = [];
    }
    notifyListeners();
    Future.value();
  }
}

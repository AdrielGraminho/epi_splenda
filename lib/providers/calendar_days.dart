import 'package:flutter/material.dart';
import 'package:splenda_epi/services/calendar_service.dart';

class CalendarDays extends ChangeNotifier {
  List<DateTime> _listDate = [];
  List<DateTime> get listDate => _listDate;

  Future<void> getDays(BuildContext context) async {
    notifyListeners();
    _listDate = await Future.value(CalendarService().findAllDate(context));
    return Future.value();
  }
}

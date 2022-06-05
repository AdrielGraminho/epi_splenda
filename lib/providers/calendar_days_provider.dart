import 'package:flutter/material.dart';
import 'package:splenda_epi/services/calendar_service.dart';

class CalendarDays extends ChangeNotifier {
  List<DateTime> _listDate = [];
  List<DateTime> get listDate => _listDate;

  Future<void> getDays(BuildContext context) async {
    _listDate.clear();
    _listDate = await Future.value(CalendarService().findAllDate(context));
    notifyListeners();
    return Future.value();
  }
}

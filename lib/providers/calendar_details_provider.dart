import 'package:flutter/material.dart';
import 'package:splenda_epi/models/day_details.dart';

import '../services/calendar_details_service.dart';

class CalendarDetailsProvider extends ChangeNotifier {
  List<DayDetails> _dayDetailsList = [];

  List<DayDetails> get dayDetailsList => _dayDetailsList;

  Future<void> getDayDetailsTotalPermission(
      DateTime day, BuildContext context) async {
    try {
      _dayDetailsList = await CalendarDetailsService()
          .getDayDetailsTotalPermission(day, context);
    } catch (e) {
      _dayDetailsList = [];
    }
    notifyListeners();
    return Future.value();
  }

  Future<void> getDayDetailsBuPermissionPermission(
      DateTime day, int idBusinessUnit, BuildContext context) async {
    try {
      _dayDetailsList = await CalendarDetailsService()
          .getDayDetailsBuPermissionPermission(day, idBusinessUnit, context);
    } catch (e) {
      _dayDetailsList = [];
    }
    notifyListeners();
    return Future.value();
  }

  Future<void> clean() async {
    _dayDetailsList.clear();
    notifyListeners();
    return Future.value();
  }
}

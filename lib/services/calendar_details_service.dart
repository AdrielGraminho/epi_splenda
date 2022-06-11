import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splenda_epi/models/day_details.dart';
import 'package:splenda_epi/shared/data/store.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class CalendarDetailsService {
  Future<List<DayDetails>> getDayDetailsTotalPermission(
      DateTime day, BuildContext context) async {
    List<DayDetails> dayDetailsList = [];

    String _uri = Constants.baseUrl + 'deadline/day';

    final token = await Store.getToken(context);

    final response = await http.get(
      Uri.parse(_uri +
          '?idBusinessUnit=' +
          '&date=' +
          DateFormat('y-MM-dd').format(day)),
      headers: {'Authorization': 'Bearer $token'},
    );
    List data = json.decode(response.body);

    data.forEach((element) {
      dayDetailsList.add(DayDetails(
        idDeadLine: element['idDeadLine'],
        description: element['description'],
        businessUnit: element['businessUnit'],
      ));
    });

    return Future.value(dayDetailsList);
  }

  Future<List<DayDetails>> getDayDetailsBuPermissionPermission(
      DateTime day, int idBusinessUnit, BuildContext context) async {
    List<DayDetails> dayDetailsList = [];

    String _uri = Constants.baseUrl + 'deadline/day';

    final token = await Store.getToken(context);

    final response = await http.get(
      Uri.parse(_uri +
          '?idBusinessUnit=' +
          idBusinessUnit.toString() +
          '&date=' +
          DateFormat('y-MM-dd').format(day)),
      headers: {'Authorization': 'Bearer $token'},
    );
    List data = json.decode(response.body);

    for (var element in data) {
      dayDetailsList.add(DayDetails(
        idDeadLine: element['idDeadLine'],
        description: element['description'],
        businessUnit: element['businessUnit'],
      ));
    }

    return Future.value(dayDetailsList);
  }
}

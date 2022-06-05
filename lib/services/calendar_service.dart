import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splenda_epi/utils/constants.dart';

import '../shared/data/store.dart';
import 'package:http/http.dart' as http;

class CalendarService {
  Future<List<DateTime>> findAllDate(BuildContext context) async {
    String _uri = Constants.baseUrl + 'deadline/expiration';

    final token = await Store.getToken(context);

    final response = await http.get(
      Uri.parse(_uri),
      headers: {'Authorization': 'Bearer $token'},
    );

    List<dynamic> data = json.decode(response.body);

    List<DateTime> dateList = [];

    data.forEach((date) {
      dateList.add(DateTime.parse(date.toString()));
    });

    return dateList;
  }
}

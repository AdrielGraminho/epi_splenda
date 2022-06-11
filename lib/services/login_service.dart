import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splenda_epi/providers/account_details_provider.dart';
import 'package:splenda_epi/providers/audit_provider.dart';
import 'package:splenda_epi/providers/business_unit_provider.dart';
import 'package:splenda_epi/providers/item_provider.dart';
import 'package:splenda_epi/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../providers/calendar_days_provider.dart';
import '../screens/calendar_screen.dart';
import '../shared/data/store.dart';

class LoginService {
  final Uri _url = Uri.parse(Constants.baseUrl + 'auth/signin');
  String? _token;
  DateTime? _expiryDate;
  int? _localId;
  String? _userName;
  String? _email;
  String? _nameRole;

  Future<void> authenticate(
      String userName, String password, BuildContext context) async {
    final response = await http.post(
      _url,
      body: jsonEncode({'username': userName.trim(), 'password': password}),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    if (response.statusCode.toString() != '200') {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Erro ao autenticar"),
                content: const Text("Verifique seu usuário e senha, por favor"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Fechar'))
                ],
              ));
    } else {
      final responseBody = json.decode(response.body);
      setParameters(responseBody);
      await storeParameter();
      await loadData(context);
      await Provider.of<AccountDetailsProvider>(context, listen: false)
          .getAccountDetails();

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CalendarScreen()));
    }
  }

  Future<void> loadData(BuildContext context) async {
    try {
      await Provider.of<BusinessUnitProvider>(context, listen: false)
          .getBusinessUnitByPermission(context);
      await Provider.of<CalendarDays>(context, listen: false).getDays(context);
      await Provider.of<ItemProvider>(context, listen: false)
          .findAllItems(context);
      await Provider.of<AuditProvider>(context, listen: false)
          .findAllAuditType(context);
    } on Exception catch (_) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Erro ao autenticar"),
                content: const Text("Verifique seu usuário e senha, por favor"),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text('Fechar'))
                ],
              ));
    }
  }

  setParameters(responseBody) {
    _token = responseBody['accessToken'];
    _expiryDate = DateTime.now().add(
      Duration(milliseconds: responseBody['expToken'] ?? 0),
    );
    _localId = responseBody['id'];
    _userName = responseBody['username'];
    _email = responseBody['email'];
    _nameRole = responseBody['nameRole'];
  }

  Future<void> storeParameter() async {
    await Store.saveMap('userData', {
      'token': _token,
      'expiryDate': _expiryDate!.toIso8601String(),
      'localId': _localId.toString(),
      'email': _email,
      'userName': _userName,
      'nameRole': _nameRole
    });
  }
}

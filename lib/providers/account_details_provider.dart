import 'package:flutter/widgets.dart';
import 'package:splenda_epi/models/account_details.dart';

import '../shared/data/store.dart';

class AccountDetailsProvider extends ChangeNotifier {
  AccountDetails? _accountDetails;
  AccountDetails? get accountDetails => _accountDetails;
  Future<void> getAccountDetails() async {
    final userData = await Store.getMap('userData');
    String userName = userData['userName'];
    String email = userData['email'];
    String nameRole = userData['nameRole'];

    _accountDetails =
        AccountDetails(nameRole: nameRole, email: email, username: userName);
    notifyListeners();
  }
}

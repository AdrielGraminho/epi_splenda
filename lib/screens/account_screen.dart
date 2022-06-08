import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/button.dart';
import 'package:splenda_epi/components/public/custom_text_label.dart';
import 'package:splenda_epi/components/public/title_field.dart';
import 'package:splenda_epi/models/account_details.dart';
import 'package:splenda_epi/providers/account_details_provider.dart';
import 'package:splenda_epi/providers/count_page.dart';
import 'package:splenda_epi/screens/login_screen.dart';
import 'package:splenda_epi/shared/data/store.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AccountDetails accountDetails =
        Provider.of<AccountDetailsProvider>(context, listen: false)
            .accountDetails;
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleField(title: 'Conta'),
        Padding(
          padding: EdgeInsets.all(32.0),
          child: CustomTextLabel(text: 'Nome: ${accountDetails.username}'),
        ),
        Padding(
          padding: EdgeInsets.only(left: 32),
          child: CustomTextLabel(text: "E-email: ${accountDetails.email}"),
        ),
        Padding(
          padding: EdgeInsets.all(32.0),
          child: CustomTextLabel(
              text:
                  "Permissão: ${accountDetails.nameRole == 'bu' ? 'Unidade' : accountDetails.nameRole}"),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Button(
              label: "Sair",
              function: () async {
                await Store.remove('userData');
                Provider.of<CountPage>(context, listen: false)
                    .incrementCounter(0);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }),
        ),
      ],
    );
    return BaseScreen(child: child);
  }
}

import 'package:flutter/material.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/button.dart';
import 'package:splenda_epi/components/public/custom_text_label.dart';
import 'package:splenda_epi/components/public/title_field.dart';
import 'package:splenda_epi/screens/login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleField(title: 'Conta'),
        const Padding(
          padding: EdgeInsets.all(32.0),
          child: CustomTextLabel(text: "Nome: Adriel Graminho"),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 32),
          child: CustomTextLabel(
              text: "E-email: adriel.graminho@splendasa.com.br"),
        ),
        const Padding(
          padding: EdgeInsets.all(32.0),
          child: CustomTextLabel(text: "Permissão: Total"),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Button(
              label: "Sair",
              function: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginScreen()))),
        ),
      ],
    );
    return BaseScreen(child: child);
  }
}

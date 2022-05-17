import 'package:flutter/material.dart';
import 'package:splenda_epi/components/public/base_text_field.dart';
import 'package:splenda_epi/components/public/button.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/screens/calendar_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.4,
          child: const Image(image: AssetImage('images/logo_splenda.png')),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                BaseTextField(text: "E-mail", onChange: () => print("changed")),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: BaseTextField(
                      text: "Senha",
                      onChange: () => print("teste"),
                      isPassword: true),
                ),
                Button(
                    label: "Entrar",
                    function: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CalendarScreen()))),
              ],
            ),
          ),
        )
      ],
    );

    return BaseScreen(
      child: child,
      navigation: false,
      topBar: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/title_field.dart';

import '../components/public/base_text_field.dart';
import '../components/public/button.dart';
import '../components/public/custom_dropdown_field.dart';

class RecivedEpiScreen extends StatefulWidget {
  const RecivedEpiScreen({Key? key}) : super(key: key);

  @override
  State<RecivedEpiScreen> createState() => _RecivedEpiScreenState();
}

class _RecivedEpiScreenState extends State<RecivedEpiScreen> {
  String dropDownValue = '';

  @override
  Widget build(BuildContext context) {
    Widget _child = Column(children: [
      const TitleField(title: "Devolução de EPIs"),
      CustomDropDownField(
          onChange: (String value) {
            setState(() {
              dropDownValue = value;
            });
          },
          options: ['', 'Luva'],
          dropDownValue: dropDownValue),
      Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              BaseTextField(
                  text: "CPF do Colaborador",
                  onChange: () => print("teste"),
                  isPassword: false),
              const SizedBox(
                height: 16,
              ),
              BaseTextField(
                  text: "Nome do Colaborador",
                  onChange: () => print("teste"),
                  isPassword: false),
              Button(label: "Salvar", function: () {}),
            ],
          ))
    ]);
    return BaseScreen(
      child: _child,
      navigation: true,
    );
  }
}

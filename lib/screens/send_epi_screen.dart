import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/custom_dropdown_field.dart';
import 'package:splenda_epi/components/public/title_field.dart';
import 'package:splenda_epi/providers/item_provider.dart';

import '../components/public/base_text_field.dart';
import '../components/public/button.dart';

class SendEpiScreen extends StatefulWidget {
  const SendEpiScreen({Key? key}) : super(key: key);

  @override
  State<SendEpiScreen> createState() => _SendEpiScreenState();
}

class _SendEpiScreenState extends State<SendEpiScreen> {
  String dropDownValue = '';
  List<String> dropDownOtions = [''];
  TextEditingController cpfController = TextEditingController();
  TextEditingController employeeController = TextEditingController();
  var Idemployee;

  @override
  void initState() {
    dropDownOtions.clear();
    dropDownOtions.add('');
    dropDownOtions.addAll(Provider.of<ItemProvider>(context, listen: false)
        .itemList
        .map((e) => e.idItem.toString() + ' ' + e.description.toString())
        .toList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void handleChangeCpf() {}
    Widget _child = Column(children: [
      const TitleField(title: "Entrega de EPIs"),
      CustomDropDownField(
          onChange: (String value) {
            setState(() {
              dropDownValue = value;
            });
          },
          options: dropDownOtions,
          dropDownValue: dropDownValue),
      Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              BaseTextField(
                label: "CPF do Colaborador",
                controller: cpfController,
                isPassword: false,
                onChange: () {
                  handleChangeCpf();
                },
              ),
              SizedBox(
                height: 16,
              ),
              BaseTextField(
                  isDisabled: true,
                  label: "Nome do Colaborador",
                  controller: employeeController,
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

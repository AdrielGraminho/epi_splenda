import 'package:flutter/material.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/box_field_date.dart';
import 'package:splenda_epi/components/public/custom_text_label.dart';
import 'package:splenda_epi/components/public/title_field.dart';

import '../components/public/custom_dropdown_field.dart';

class PpraPcmsoScreen extends StatefulWidget {
  const PpraPcmsoScreen({Key? key}) : super(key: key);

  @override
  State<PpraPcmsoScreen> createState() => _PpraPcmsoScreenState();
}

class _PpraPcmsoScreenState extends State<PpraPcmsoScreen> {
  List<String> optionsMock = ["", "1001- Ortobom"];

  String dropDownValue = "";

  void onChangeDropdownField(String newValue) {
    setState(() {
      dropDownValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Column(children: [
      const TitleField(title: 'PPRA e PCMSO'),
      CustomDropDownField(
        onChange: onChangeDropdownField,
        options: optionsMock,
        dropDownValue: dropDownValue,
      ),
      Column(
        children: dropDownValue == ''
            ? []
            : [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CustomTextLabel(text: 'Data de expiração PPRA:'),
                    ),
                  ],
                ),
                Center(
                  child: BoxFieldDate(dateField: DateTime.now()),
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(32.0),
                      child: CustomTextLabel(text: "Data de expiração PCMSO:"),
                    ),
                  ],
                ),
                Center(
                  child: BoxFieldDate(dateField: DateTime.now()),
                )
              ],
      ),
    ]);
    return BaseScreen(child: child);
  }
}

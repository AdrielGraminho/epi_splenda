import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/title_field.dart';

import '../components/public/custom_dropdown_field.dart';

class DayDetailsScreen extends StatefulWidget {
  const DayDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DayDetailsScreen> createState() => _DayDetailsScreenState();
}

class _DayDetailsScreenState extends State<DayDetailsScreen> {
  String dropDownValue = "";
  List<String> dropDownOtions = ["", "Unidade 1"];

  void setDropDown(String newValue) {
    setState(() {
      dropDownValue = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map dataRecivced = ModalRoute.of(context)!.settings.arguments as Map;

    DateTime daySelected = dataRecivced["daySelected"];

    Widget child = Column(
      children: [
        const TitleField(title: "Detalhes do dia"),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              DateFormat("'Dia selecionado: ' dd/MM/yyyy").format(daySelected),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomDropDownField(
              onChange: setDropDown,
              options: dropDownOtions,
              dropDownValue: dropDownValue),
        )
      ],
    );
    return BaseScreen(child: child);
  }
}

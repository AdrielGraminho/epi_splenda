import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/title_field.dart';

import '../components/public/base_text_field.dart';
import '../components/public/button.dart';
import '../components/public/custom_dropdown_field.dart';
import '../providers/employee_provider.dart';
import '../providers/item_provider.dart';

class RecivedEpiScreen extends StatefulWidget {
  const RecivedEpiScreen({Key? key}) : super(key: key);

  @override
  State<RecivedEpiScreen> createState() => _RecivedEpiScreenState();
}

class _RecivedEpiScreenState extends State<RecivedEpiScreen> {
  String dropDownValue = '';
  List<String> dropDownOtions = [''];
  TextEditingController cpfController = TextEditingController();
  TextEditingController employeeController = TextEditingController();
  int? idItem;

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
    var idEmployee =
        Provider.of<EmployeeProvider>(context, listen: false).idEmployee;
    String name = Provider.of<EmployeeProvider>(context, listen: false).name;
    Future<void> handleChangeCpf(String cpf) async {
      try {
        await Provider.of<EmployeeProvider>(context, listen: false)
            .findEmployeeByCpf(cpf, context);
      } catch (e) {
        // print(e);
      }

      setState(() {
        name = Provider.of<EmployeeProvider>(context, listen: false).name;
        idEmployee =
            Provider.of<EmployeeProvider>(context, listen: false).idEmployee;
      });
    }

    Widget _child = Column(children: [
      const TitleField(title: "Devolução de EPIs"),
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
                onChange: (val) {
                  handleChangeCpf(val);
                },
              ),
              SizedBox(
                height: 16,
              ),
              BaseTextField(
                  isDisabled: true,
                  label: name,
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

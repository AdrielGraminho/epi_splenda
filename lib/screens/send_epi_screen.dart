import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/custom_dropdown_field.dart';
import 'package:splenda_epi/components/public/title_field.dart';
import 'package:splenda_epi/providers/employee_provider.dart';
import 'package:splenda_epi/providers/item_provider.dart';
import 'package:splenda_epi/services/exit_service.dart';

import '../components/public/base_text_field.dart';
import '../components/public/button.dart';
import '../providers/calendar_days_provider.dart';
import '../providers/count_page.dart';
import 'calendar_screen.dart';

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
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BaseTextField(
                label: "CPF do Colaborador",
                controller: cpfController,
                onChange: (val) {
                  handleChangeCpf(val);
                },
              ),
              const SizedBox(
                height: 16,
              ),
              BaseTextField(
                  isDisabled: true,
                  label: name,
                  controller: employeeController,
                  isPassword: false),
              Button(
                  label: "Salvar",
                  function: () {
                    Provider.of<ItemProvider>(context, listen: false)
                        .itemList
                        .forEach((element) {
                      if (element.idItem.toString() +
                              ' ' +
                              element.description.toString() ==
                          dropDownValue) {
                        idItem = element.idItem;
                      }
                    });
                    if (idEmployee != null && idItem != null) {
                      ExitService()
                          .send(
                              context, idEmployee.toString(), idItem.toString())
                          .then((_) {
                        Provider.of<CalendarDays>(context, listen: false)
                            .getDays(context)
                            .then((_) {
                          Provider.of<CountPage>(context, listen: false)
                              .incrementCounter(0);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CalendarScreen()));
                        });
                      });
                    }
                  }),
            ],
          ))
    ]);
    return BaseScreen(
      child: _child,
      navigation: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/title_field.dart';
import 'package:splenda_epi/services/recived_service.dart';

import '../components/public/base_text_field.dart';
import '../components/public/button.dart';
import '../components/public/custom_dropdown_field.dart';
import '../providers/calendar_days_provider.dart';
import '../providers/count_page.dart';
import '../providers/employee_provider.dart';
import '../providers/item_provider.dart';
import 'calendar_screen.dart';

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
  int? idExit;

  @override
  Widget build(BuildContext context) {
    var idEmployee =
        Provider.of<EmployeeProvider>(context, listen: false).idEmployee;

    String name = Provider.of<EmployeeProvider>(context, listen: false).name;

    void handleChangeItem() {
      if (idEmployee != null) {
        Provider.of<ItemProvider>(context, listen: false)
            .findByEmployeeId(context, idEmployee!)
            .then((_) {
          List<String> options = [''];
          options.addAll(Provider.of<ItemProvider>(context, listen: false)
              .itemListEmployee
              .map((e) =>
                  e.idItem.toString() +
                  ' ' +
                  e.description.toString() +
                  ' ' +
                  e.idExit.toString())
              .toList());
          setState(() {
            dropDownOtions = options;
          });
        });
      } else {
        setState(() {
          dropDownValue = '';
          dropDownOtions = [''];
        });
      }
    }

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
      handleChangeItem();
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
                        .itemListEmployee
                        .forEach((element) {
                      if (element.idItem.toString() +
                              ' ' +
                              element.description.toString() +
                              ' ' +
                              element.idExit.toString() ==
                          dropDownValue) {
                        idExit = element.idExit;
                      }
                      if (idExit != null) {
                        RecivedService()
                            .send(context, idExit.toString())
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
                    });
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

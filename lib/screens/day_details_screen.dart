import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/box_field_date.dart';
import 'package:splenda_epi/components/public/box_list.dart';
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

  List<Map<String, dynamic>> dataMock = [
    {
      "businessUnitCode": 1001,
      "BusinessUnitDescription": "Ortobom",
      "items": [
        {
          "idItem": 1,
          "itemName": "PPRA",
        },
        {
          "idItem": 2,
          "itemName": "Luva do funcionário: ******",
        }
      ]
    },
    {
      "businessUnitCode": 10054,
      "BusinessUnitDescription": "Exatron",
      "items": [
        {"itemName": "PCMSO"},
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    Map dataRecivced = ModalRoute.of(context)!.settings.arguments as Map;

    DateTime daySelected = dataRecivced["daySelected"];

    Widget child = Column(
      children: [
        const TitleField(title: "Detalhes do dia"),
        BoxFieldDate(dateField: daySelected),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomDropDownField(
              onChange: setDropDown,
              options: dropDownOtions,
              dropDownValue: dropDownValue),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: dataMock.length,
            itemBuilder: ((context, index) {
              String businessUnitCode =
                  dataMock.elementAt(index)['businessUnitCode'].toString();
              String businessUnitDescription = dataMock
                  .elementAt(index)['BusinessUnitDescription']
                  .toString();

              List<Map<String, dynamic>> items =
                  dataMock.elementAt(index)['items'];

              return BoxList(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      String itemDescription =
                          items.elementAt(index)['itemName'].toString();
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(itemDescription,
                              style: TextStyle(
                                  color: daySelected.isAfter(DateTime.now())
                                      ? Colors.black
                                      : Colors.red)),
                        ),
                      );
                    }),
                title: businessUnitCode + " - " + businessUnitDescription,
              );
            }))
      ],
    );
    return BaseScreen(child: child);
  }
}

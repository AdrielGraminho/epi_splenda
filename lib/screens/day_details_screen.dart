import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/box_field_date.dart';
import 'package:splenda_epi/components/public/box_list.dart';
import 'package:splenda_epi/components/public/title_field.dart';
import 'package:splenda_epi/models/day_details.dart';
import '../components/public/custom_dropdown_field.dart';
import '../providers/calendar_details_provider.dart';

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
    List<DayDetails> data =
        Provider.of<CalendarDetailsProvider>(context, listen: false)
            .dayDetailsList;
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
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              String itemDescription = data.elementAt(index).description;
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BoxList(
                    child: Center(
                      child: Text(itemDescription,
                          style: TextStyle(
                              color: daySelected.isAfter(DateTime.now())
                                  ? Colors.black
                                  : Colors.red)),
                    ),
                    title: data.elementAt(index).businessUnit,
                  ));
            }),
      ],
    );
    return BaseScreen(child: child);
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/box_field_date.dart';
import 'package:splenda_epi/components/public/custom_text_label.dart';
import 'package:splenda_epi/components/public/title_field.dart';
import 'package:splenda_epi/models/ppra_pcmso.dart';
import 'package:splenda_epi/providers/ppra_pcmso_provider.dart';

import '../components/public/custom_dropdown_field.dart';
import '../providers/business_unit_provider.dart';

class PpraPcmsoScreen extends StatefulWidget {
  const PpraPcmsoScreen({Key? key}) : super(key: key);

  @override
  State<PpraPcmsoScreen> createState() => _PpraPcmsoScreenState();
}

class _PpraPcmsoScreenState extends State<PpraPcmsoScreen> {
  List<String> dropDownOtions = [""];
  int? selectedBusinessUnit;
  DateTime? ppraDate;
  DateTime? pcmsoDate;

  @override
  void initState() {
    dropDownOtions.clear();
    dropDownOtions.add('');
    dropDownOtions.addAll(
        Provider.of<BusinessUnitProvider>(context, listen: false)
            .businessUnit
            .map((e) => e.code.toString() + ' ' + e.description.toString())
            .toList());
    super.initState();
  }

  String dropDownValue = "";

  @override
  Widget build(BuildContext context) {
    List<PpraPcmso> ppraPcmsoList =
        Provider.of<PpraPcmsoProvider>(context, listen: false).ppraPcmsoList;
    void onChangeDropdownField(String newValue) {
      Provider.of<BusinessUnitProvider>(context, listen: false)
          .businessUnit
          .forEach((businessUnit) => {
                if (newValue ==
                    businessUnit.code.toString() +
                        ' ' +
                        businessUnit.description.toString())
                  {selectedBusinessUnit = businessUnit.idBusinessUnit}
              });

      Provider.of<PpraPcmsoProvider>(context, listen: false)
          .findPpraPcmsoByBusinessUnit(context, selectedBusinessUnit!);
      setState(() {
        dropDownValue = newValue;
        ppraDate = ppraPcmsoList
            .firstWhere((element) => element.ppraAndPcmsoType == 'PPRA')
            .expirationDate;

        pcmsoDate = ppraPcmsoList
            .firstWhere((element) => element.ppraAndPcmsoType == 'PCMSO')
            .expirationDate;
      });
    }

    Widget child = Column(children: [
      const TitleField(title: 'PPRA e PCMSO'),
      CustomDropDownField(
        onChange: onChangeDropdownField,
        options: dropDownOtions,
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
                  child: BoxFieldDate(dateField: ppraDate!),
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
                  child: BoxFieldDate(dateField: pcmsoDate!),
                )
              ],
      ),
    ]);
    return BaseScreen(child: child);
  }
}

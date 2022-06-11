import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/box_list.dart';
import 'package:splenda_epi/components/public/custom_dropdown_field.dart';
import 'package:splenda_epi/components/public/title_field.dart';
import 'package:splenda_epi/models/audit_item.dart';
import 'package:splenda_epi/models/audit_type.dart';
import 'package:splenda_epi/services/audit_service.dart';

import '../providers/audit_provider.dart';
import '../providers/business_unit_provider.dart';

class AuditScreen extends StatefulWidget {
  const AuditScreen({Key? key}) : super(key: key);

  @override
  State<AuditScreen> createState() => _AuditScreenState();
}

List<String> dropDownOtions = [''];
int? selectedBusinessUnit;

class _AuditScreenState extends State<AuditScreen> {
  String dropDownValue = "";

  String dropDownItem = '';
  List<int> isAproved = [];
  List<int> isReproved = [];
  List<int> isNotAplicable = [];

  void setDropDown(String newValue) {
    Provider.of<BusinessUnitProvider>(context, listen: false)
        .businessUnit
        .forEach((businessUnit) => {
              if (newValue ==
                  businessUnit.code.toString() +
                      ' ' +
                      businessUnit.description.toString())
                {selectedBusinessUnit = businessUnit.idBusinessUnit}
            });
    setState(() {
      dropDownValue = newValue;
      isAproved.clear();
      isReproved.clear();
      isNotAplicable.clear();
    });
  }

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

  @override
  Widget build(BuildContext context) {
    List<AuditType> auditTypeList =
        Provider.of<AuditProvider>(context, listen: false).auditTypeList;
    Widget child = Column(
      children: [
        const TitleField(title: "Auditoria"),
        CustomDropDownField(
            onChange: setDropDown,
            options: dropDownOtions,
            dropDownValue: dropDownValue),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: dropDownValue != ''
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: auditTypeList.length,
                  itemBuilder: (context, index) {
                    String title = auditTypeList
                        .elementAt(index)
                        .description
                        .toString()
                        .trim();
                    List<AuditItem> items =
                        auditTypeList.elementAt(index).auditItemList;
                    int idAuditType =
                        auditTypeList.elementAt(index).idAuditType;
                    return BoxList(
                        title: idAuditType.toString() + '- ' + title,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: ((context, index) {
                              String itemDescription =
                                  items.elementAt(index).description.toString();
                              int idItem = int.parse(items
                                  .elementAt(index)
                                  .idAuditItem
                                  .toString());
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(itemDescription),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                          checkColor: Colors.green,
                                          value: isAproved.contains(idItem),
                                          onChanged: (val) {
                                            setState(() {
                                              if (isAproved.contains(idItem)) {
                                                isAproved.remove(idItem);
                                              } else {
                                                print(selectedBusinessUnit);
                                                //todo aqui vai enviar para o backend o id
                                                AuditService().send(
                                                    context,
                                                    selectedBusinessUnit!,
                                                    idItem,
                                                    'APPROVED');
                                                isAproved.add(idItem);
                                                isReproved.remove(idItem);
                                                isNotAplicable.remove(idItem);
                                              }
                                            });
                                          }),
                                      const Text(
                                        'Conforme',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                          checkColor: Colors.red,
                                          value: isReproved.contains(idItem),
                                          onChanged: (val) {
                                            setState(() {
                                              if (isReproved.contains(idItem)) {
                                                isReproved.remove(idItem);
                                              } else {
                                                AuditService().send(
                                                    context,
                                                    selectedBusinessUnit!,
                                                    idItem,
                                                    'DISAPPROVED');
                                                isReproved.add(idItem);
                                                isAproved.remove(idItem);
                                                isNotAplicable.remove(idItem);
                                              }
                                            });
                                          }),
                                      const Text(
                                        'Não Conforme',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                          checkColor: Colors.blue,
                                          value:
                                              isNotAplicable.contains(idItem),
                                          onChanged: (val) {
                                            setState(() {
                                              if (isNotAplicable
                                                  .contains(idItem)) {
                                                isNotAplicable.remove(idItem);
                                              } else {
                                                AuditService().send(
                                                    context,
                                                    selectedBusinessUnit!,
                                                    idItem,
                                                    'NOT_APPLICABLE');
                                                isNotAplicable.add(idItem);

                                                isReproved.remove(idItem);
                                                isAproved.remove(idItem);
                                              }
                                            });
                                          }),
                                      const Text(
                                        'Não Aplicável',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )
                                ],
                              );
                            })));
                  },
                )
              : null,
        )
      ],
    );
    return BaseScreen(child: child);
  }
}

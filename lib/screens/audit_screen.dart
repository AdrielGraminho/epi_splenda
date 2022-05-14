import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/box_list.dart';
import 'package:splenda_epi/components/public/dropdownField.dart';
import 'package:splenda_epi/components/public/title_field.dart';

class AuditScreen extends StatefulWidget {
  const AuditScreen({Key? key}) : super(key: key);

  @override
  State<AuditScreen> createState() => _AuditScreenState();
}

class _AuditScreenState extends State<AuditScreen> {
  List<Map<String, dynamic>> mock = [
    {
      "auditType": {
        "idType": 1,
        "title":
            "Veniam reprehenderit veniam aute ut sint proident duis proident.",
        "items": {
          {
            "idItem": 1,
            "itemDescription":
                "Commodo amet occaecat aliqua cillum sint incididunt.Fugiat nisi qui anim ullamco aliqua eu eiusmod nulla esse quis culpa deserunt."
          },
          {
            "idItem": 2,
            "itemDescription":
                "Aliquip in minim sint fugiat sint est anim anim sit culpa in pariatur do."
          }
        }
      },
    },
    {
      "auditType": {
        "idType": 2,
        "title":
            "Culpa elit occaecat ullamco voluptate eu qui commodo officia Lorem aute qui ipsum.",
        "items": {
          {
            "idItem": 3,
            "itemDescription":
                "Commodo amet occaecat aliqua cillum sint incididunt.Fugiat nisi qui anim ullamco aliqua eu eiusmod nulla esse quis culpa deserunt."
          },
          {
            "idItem": 4,
            "itemDescription":
                "Incididunt eu tempor sint enim ullamco exercitation proident officia consectetur et minim labore."
          }
        }
      },
    },
  ];

  String dropDownValue = '';
  String dropDownItem = '';
  List<int> isAproved = [];
  List<int> isReproved = [];
  List<int> isNotAplicable = [];

  void setDropDown(String newValue) {
    setState(() {
      dropDownValue = newValue;
      isAproved.clear();
      isReproved.clear();
      isNotAplicable.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      children: [
        const TitleField(title: "Auditoria"),
        DropDownField(
            onChange: setDropDown,
            options: ['', 'Unidate 1', 'Unidade 2', 'Unidade 3', 'Unidade 4'],
            dropDownValue: dropDownValue),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: dropDownValue != ''
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: mock.length,
                  itemBuilder: (context, index) {
                    String title =
                        mock.elementAt(index)['auditType']['title'].toString();
                    LinkedHashSet<Map<String, Object>> items =
                        mock.elementAt(index)['auditType']['items'];
                    int idAuditType =
                        mock.elementAt(index)['auditType']['idType'];
                    return BoxList(
                        title: idAuditType.toString() + '- ' + title,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: ((context, index) {
                              String itemDescription = items
                                  .elementAt(index)['itemDescription']
                                  .toString();
                              int idItem = int.parse(
                                  items.elementAt(index)['idItem'].toString());
                              return Column(
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

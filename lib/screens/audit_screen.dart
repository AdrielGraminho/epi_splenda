import 'package:flutter/material.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/title_field.dart';

class AuditScreen extends StatefulWidget {
  const AuditScreen({Key? key}) : super(key: key);

  @override
  State<AuditScreen> createState() => _AuditScreenState();
}

class _AuditScreenState extends State<AuditScreen> {
  List<Map<String, dynamic>> mock = [
    {
      "id": 1,
      "item": {
        "title": "teste 1",
        "description":
            "Laboris ad aute voluptate commodo do do sit esse cupidatat dolore ad aliqua."
      }
    },
    {
      "id": 2,
      "item": {
        "title": "teste 2",
        "description": "Sunt eiusmod minim amet qui laboris sit cupidatat."
      }
    },
    {
      "id": 3,
      "item": {
        "title": "teste 3",
        "description":
            "Ea eiusmod deserunt sit tempor Lorem excepteur irure consectetur sit consequat dolore."
      }
    },
    {
      "id": 4,
      "item": {
        "title": "teste 4",
        "description":
            "Elit deserunt aliquip exercitation velit sunt velit aute nostrud."
      }
    }
  ];

  String dropDownValue = '';
  String dropDownItem = '';
  List<int> isAproved = [];
  List<int> isReproved = [];
  List<int> isNotAplicable = [];

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      children: [
        const TitleField(title: "Auditoria"),
        SizedBox(
          child: DropdownButton<String>(
            value: dropDownValue,
            alignment: Alignment.bottomCenter,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            items:
                <String>['', 'Unidate 1', 'Unidade 2', 'Unidade 3', 'Unidade 4']
                    .map<DropdownMenuItem<String>>(
                      (String item) => DropdownMenuItem<String>(
                        child: Text(item),
                        value: item,
                      ),
                    )
                    .toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropDownValue = newValue!;
              });
            },
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: mock.length,
            itemBuilder: (context, index) {
              String title = mock.elementAt(index)['item']['title'].toString();
              String description =
                  mock.elementAt(index)['item']['description'].toString();
              int id = mock.elementAt(index)['id'];
              return Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      color: const Color.fromARGB(255, 254, 204, 22)),
                  child: Container(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(id.toString() + '- ' + title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Text(description),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              checkColor: Colors.green,
                              value: isAproved.contains(id),
                              onChanged: (val) {
                                setState(() {
                                  if (isAproved.contains(id)) {
                                    isAproved.remove(id);
                                  } else {
                                    isAproved.add(id);
                                    isReproved.remove(id);
                                    isNotAplicable.remove(id);
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
                              value: isReproved.contains(id),
                              onChanged: (val) {
                                setState(() {
                                  if (isReproved.contains(id)) {
                                    isReproved.remove(id);
                                  } else {
                                    isReproved.add(id);
                                    isAproved.remove(id);
                                    isNotAplicable.remove(id);
                                  }
                                });
                              }),
                          const Text(
                            'Não Conforme',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              checkColor: Colors.blue,
                              value: isNotAplicable.contains(id),
                              onChanged: (val) {
                                setState(() {
                                  if (isNotAplicable.contains(id)) {
                                    isNotAplicable.remove(id);
                                  } else {
                                    isNotAplicable.add(id);

                                    isReproved.remove(id);
                                    isAproved.remove(id);
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
                    ]),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
    return BaseScreen(child: child);
  }
}

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
              return Container(
                padding: const EdgeInsets.all(16.0),
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.black),
                        left: BorderSide(width: 1.0, color: Colors.black),
                        right: BorderSide(width: 1.0, color: Colors.black),
                        bottom: BorderSide(width: 1.0, color: Colors.black),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      color: Color.fromARGB(255, 254, 204, 22)),
                  child: Container(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(title),
                              ],
                            )),
                            const Icon(Icons.arrow_downward),
                          ],
                        ),
                      ),
                      Text(description),
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

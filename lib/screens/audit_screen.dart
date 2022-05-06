import 'package:flutter/material.dart';
import 'package:splenda_epi/components/public/base_screen.dart';
import 'package:splenda_epi/components/public/title_field.dart';

class AuditScreen extends StatefulWidget {
  const AuditScreen({Key? key}) : super(key: key);

  @override
  State<AuditScreen> createState() => _AuditScreenState();
}

class _AuditScreenState extends State<AuditScreen> {
  String dropDownValue = '';

  @override
  Widget build(BuildContext context) {
    Widget child = Column(
      children: [
        const TitleField(title: "Auditoria"),
        DropdownButton<String>(
          value: dropDownValue,
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
        )
      ],
    );
    return BaseScreen(child: child);
  }
}

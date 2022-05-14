import 'package:flutter/material.dart';

class CustomDropDownField extends StatelessWidget {
  final List<String> options;
  final String dropDownValue;
  final Function onChange;

  const CustomDropDownField(
      {Key? key,
      required this.onChange,
      required this.options,
      required this.dropDownValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownButton<String>(
        value: dropDownValue,
        alignment: Alignment.bottomCenter,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        items: options
            .map<DropdownMenuItem<String>>(
              (String item) => DropdownMenuItem<String>(
                child: Text(item),
                value: item,
              ),
            )
            .toList(),
        onChanged: (String? newValue) {
          onChange(newValue);
        },
      ),
    );
  }
}

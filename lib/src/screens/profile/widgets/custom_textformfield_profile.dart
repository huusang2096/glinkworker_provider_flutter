import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';

import 'package:simplest/simplest.dart';

class CustomTextFormFieldProfile extends StatelessWidget {
  final String textNameField;
  final String initialValue;
  final FormFieldValidator<String> validator;
  final Function onSave;
  final TextInputType textInputType;

  const CustomTextFormFieldProfile(
      {Key key,
      this.textNameField,
      this.textInputType,
      this.initialValue,
      this.validator,
      this.onSave})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: Text(textNameField.tr)),
        TextFormField(
          keyboardType: textInputType,
          initialValue: initialValue,
          validator: validator,
          onSaved: onSave,
        ),
      ],
    );
  }
}

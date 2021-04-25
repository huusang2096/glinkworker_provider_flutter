import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:simplest/simplest.dart';

class InputTextField extends StatefulWidget {
  final String placeholder;
  final Color color;
  final double radius;
  final double height;
  final double width;
  final bool obscureText;
  final TextEditingController controller;
  final int maxLines;
  final String error;
  TextInputType inputType;
  final bool enable;
  final TextCapitalization textCapitalization;
  final Function suffixOntap;
  final String suffixIconText;
  final FormFieldValidator<String> validator;
  final Widget prefixIcon;

  InputTextField(
      {this.placeholder,
      this.color,
      this.radius,
      this.height,
      this.width,
      this.obscureText = false,
      this.controller,
      this.maxLines = 1,
      this.inputType = TextInputType.text,
      this.error,
      this.enable = true,
      this.textCapitalization = TextCapitalization.none,
      this.suffixOntap,
      this.validator,
      this.prefixIcon,
      this.suffixIconText = ""});

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: widget.validator,
      textCapitalization: this.widget.textCapitalization,
      enabled: this.widget.enable,
      maxLines: this.widget.maxLines,
      controller: this.widget.controller,
      obscureText: _obscureText,
      style: textStyle,
      keyboardType: this.widget.inputType,
      decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          fillColor: widget.color,
          filled: true,
          suffixIcon: InkWell(
            onTap: widget.suffixOntap,
            child: Container(
              padding: EdgeInsets.only(top: 15),
              width: 150,
              color: Colors.black,
              child: Text(
                widget.suffixIconText.tr,
                style: body1.copyWith(color: whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 10),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.0, color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.white)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.red)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.grey)),
          hintText: widget.placeholder,
          errorText: this.widget.error),
    );
  }
}

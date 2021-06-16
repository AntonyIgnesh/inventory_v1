import 'package:flutter/material.dart';
import 'package:inventory_v1/constants.dart';

class AddProductsTextField extends StatelessWidget {
  final String lableTextForTextField;
  final Function onChangeFunction;
  final TextEditingController controller;
  final TextInputType textInputType;
  final int maxLines;
  final bool editable;
  AddProductsTextField({
    this.lableTextForTextField,
    this.onChangeFunction,
    this.controller,
    this.textInputType,
    this.maxLines,
    this.editable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black26,
      elevation: 10,
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
      child: TextField(
        enabled: editable,
        maxLines: maxLines,
        onChanged: onChangeFunction,
        style: kAddProductTextFieldStyle,
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFE2E3E3),
          labelText: lableTextForTextField,
          labelStyle: kAddProductTextFieldLableStyle,
          contentPadding: EdgeInsets.all(10),
          border: kAddProductTextFieldBorder,
          focusedBorder: kAddProductTextFieldFocusedBorder,
          // enabledBorder: kAddProductTextFieldEnabledBorder,
        ),
      ),
    );
  }
}

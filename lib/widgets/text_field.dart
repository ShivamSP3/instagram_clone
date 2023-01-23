import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String hintText;
  final bool isPass;
  final TextInputType textInputType;
  final TextEditingController controller;
  const TextFieldInput({
  super.key, 
  required this.hintText, 
  required this.controller, 
  this.isPass = false, 
  required this.textInputType
  });

  @override
  Widget build(BuildContext context) {
   final inputBorder =  OutlineInputBorder(
          borderSide: Divider.createBorderSide(context)
        );
    return TextField(
      controller:controller ,
      decoration: InputDecoration(
        hintText: hintText,
        border:inputBorder,
        focusedBorder:inputBorder ,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
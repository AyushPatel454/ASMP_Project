import 'package:flutter/material.dart';
import 'package:student_app/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass; // for check value we are passing is password or not
  final String hintText;
  final TextInputType textInputType; // for username, password, email, etc

  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final inputBorder =
    OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController, // take from constructor
      decoration: InputDecoration(
        // fillColor: Colors.blue.withOpacity(0.4),
        hintText: hintText, // take from constructor
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType, // take from constructor
      obscureText: isPass, // take from constructor
    );
  }
}
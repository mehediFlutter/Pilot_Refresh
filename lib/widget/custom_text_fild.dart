import 'package:flutter/material.dart';

TextEditingController mycontroller = TextEditingController();

Widget customTextField({
  required TextEditingController controller,
  final TextInputType? keyboardType,
  final String? hintText,
  FormFieldValidator<String>? validator,

//  required String labelText,
}) {
  return TextFormField(
     validator: validator,
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    style: const TextStyle(color: Colors.white, fontSize: 15),
    cursorColor: Colors.white,
  );
}

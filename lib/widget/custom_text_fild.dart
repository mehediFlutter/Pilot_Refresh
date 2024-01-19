import 'package:flutter/material.dart';

TextEditingController mycontroller = TextEditingController();

Widget customTextField({
  required TextEditingController controller,
 // required TextInputType keyboardType,
//  required String labelText,
}) {
  return TextField(
    controller: controller,
  //  keyboardType: keyboardType,
    decoration: InputDecoration(
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
        borderSide: BorderSide(color: Colors.white),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    ),
    style: const TextStyle(color: Colors.white, fontSize: 15),
    cursorColor: Colors.white,
  
  );
  
}

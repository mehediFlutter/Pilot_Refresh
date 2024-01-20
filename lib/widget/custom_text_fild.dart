import 'package:flutter/material.dart';

TextEditingController mycontroller = TextEditingController();

Widget customTextField({
  required TextEditingController controller,
  
 final TextInputType? keyboardType,
//  required String labelText,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
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
        borderSide: BorderSide(color: Colors.white),
      ),
     
    ),
    style: const TextStyle(color: Colors.white, fontSize: 15),
    cursorColor: Colors.white,
  
  );
  
}

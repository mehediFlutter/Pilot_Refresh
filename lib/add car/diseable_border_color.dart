import 'package:flutter/material.dart';

DropdownButtonFormField<String> borderChangedColor({
  final String? value,
  final List<String>? items,
  final Function(String? newValue)? onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    items: items?.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item),
      );
    }).toList(),
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: 'Only Partners can use this',
      contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 54, 45, 45),
        ),
      ),
    ),
    hint: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Only Partners can use this',
        style: TextStyle(color: Color.fromARGB(255, 54, 45, 45)),
      ),
    ),
  );
}





  DropdownButtonFormField<String> customDropDownFormField({
    final String? value,
    final List? list,
    final Function(String? newValue)? onChanged,
    final String? labelText,
    FormFieldValidator<String>? validator,
  }) {
    return DropdownButtonFormField<String>(
      dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,

      validator: validator,
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
        border: OutlineInputBorder(),
      ),
      //value: availableValue,
      value: value, style: TextStyle(fontSize: 15),
      items: list?.map((item) {
        return DropdownMenuItem<String>(
          //item['translate'][0]['title'] as String,
          value: item['translate'][0]['title'] as String,
          child: Text(
            item['translate'][0]['title'] as String,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }).toList(),

      onChanged: onChanged,
    );
  }

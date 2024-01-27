  import 'package:flutter/material.dart';
import 'package:pilot_refresh/advance/model_product.dart';

DropdownButtonFormField<String?> model_edition_dropdown({
    final String? value,
    final String? hintText,
    final List? list,
    final Function(String? newValue)? onChanged,
  }) {
    return DropdownButtonFormField<String?>(
      dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
        border: OutlineInputBorder(),
      ),
      value: value,
      items: list
          ?.whereType<ModelProduct>() // Filter only Product items
          .map<DropdownMenuItem<String?>>((item) {
        return DropdownMenuItem<String?>(
          value: item.name,
          child: Text(
            item.name ?? '',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
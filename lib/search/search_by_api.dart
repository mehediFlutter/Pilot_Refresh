import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/product.dart';
import 'package:pilot_refresh/service/network_caller.dart';
import 'package:pilot_refresh/service/network_response.dart';

class SearchByApi extends StatefulWidget {
  const SearchByApi({super.key});

  @override
  State<SearchByApi> createState() => _SearchByApiState();
}

List searchProducts = [];
Future<void> search(String value) async {
  Response response = await get(
      Uri.parse(
          'https://pilotbazar.com/api/merchants/vehicles/products/search?search=$value'),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json'
      },);
  Map<String, dynamic> decodedResponse = jsonDecode(response.body);
  int i = 0;

  for (i; i < decodedResponse['data'].length; i++) {
    searchProducts.add(Product(
      vehicleName: decodedResponse['data'][i]['translate'][0]['title'],
      id: decodedResponse['data'][i]['id'],
    ));
  }
  if (decodedResponse['data'] == null) {
    return;
  }
}

class _SearchByApiState extends State<SearchByApi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text(searchProducts[0].vehicleName)],
    );
  }
}

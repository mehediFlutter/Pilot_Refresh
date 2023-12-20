import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/product.dart';

class PilotSearch extends StatefulWidget {
  const PilotSearch({super.key});

  @override
  State<PilotSearch> createState() => _PilotSearchState();
}

class _PilotSearchState extends State<PilotSearch> {
  TextEditingController _searchController = TextEditingController();
  List searchProducts = [];
  Future<void> search(String value) async {
    Response response = await get(
      Uri.parse(
          'https://pilotbazar.com/api/merchants/vehicles/products/search?search=$value'),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json'
      },
    );
    Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    int i = 0;

    for (i; i < decodedResponse['payload'].length; i++) {
  
      searchProducts.add(Product(
        
        vehicleName: decodedResponse['payload'][i]['slug'],
        id: decodedResponse['payload'][i]['id'],
      ));
    }
    if (mounted) {
      setState(() {});
    }
    if (decodedResponse['data'] == null) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
  controller: _searchController,
  onSubmitted: (value)async {
  await  search(value);
  },
)
      ),
      body:ListView.builder(
        itemCount: searchProducts.length,
        itemBuilder: (context,index){
      return ListTile(
        title: Text(searchProducts[index].vehicleName),
      );

      },),);
    
  }
}

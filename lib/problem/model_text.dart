import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/problem/model_products.dart';

class ModelShowingData extends StatefulWidget {
  const ModelShowingData({Key? key}) : super(key: key);

  @override
  State<ModelShowingData> createState() => _ModelShowingDataState();
}

class _ModelShowingDataState extends State<ModelShowingData> {
  List products = [];

  Future<void> getProduct() async {
    try {
      products.clear();
      Response response = await get(
        Uri.parse("https://pilotbazar.com/api/merchants/vehicles/colors/"),
      );
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        print(decodedResponse);

        for (int i = 0; i < decodedResponse['payload'].length; i++) {
          List<Map<String, dynamic>> translateList =
              (decodedResponse['payload'][i]['translate'] as List<dynamic>)
                  .cast<Map<String, dynamic>>();

          if (translateList.isNotEmpty) {
            products.add(ModelStore(
              colorr: translateList[0]['title'] ?? '--',
              colorId: translateList[0]['translate_id'] ?? '--',
            ));
          }
        }

        setState(() {});
        print(products);
      } else {
        // Handle error if API request fails
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Model List'),
      ),
      body: products.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Column(
                    children: [
                      Text('Details'),
                      Text(products[index].colorr.toString()),
                      Text(products[index].colorId.toString()),
                    ],
                  ),
                  // Customize the ListTile as needed
                );
              },
            ),
    );
  }
}

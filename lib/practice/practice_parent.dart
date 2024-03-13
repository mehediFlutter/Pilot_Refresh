import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/practice/practice_item.dart';
import 'package:pilot_refresh/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main(){
  runApp(MaterialApp(home: ParentClass()));
}
class ParentClass extends StatefulWidget {
  @override
  _ParentClassState createState() => _ParentClassState();
}

class _ParentClassState extends State<ParentClass> {
  @override
  void initState() {
    getProduct();
    // TODO: implement initState
    super.initState();
  }
  bool myAskingPrice = true;
  List products=[];
  int?newPrice;

  late SharedPreferences prefss;
    Future getProduct() async {
    prefss = await SharedPreferences.getInstance();
    print("Here double vehicle token from share preff");
    products.clear();

    if (mounted) {
      setState(() {});
    }

    Response? response;

    if (prefss.getString('token') == null) {
      response = await get(
        Uri.parse(
            "https://pilotbazar.com/api/clients/vehicles/products?page=1"),
      );
    } else {
      response = await get(
        Uri.parse(
            "https://pilotbazar.com/api/merchants/vehicles/products?page=1"),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}',
        },
      );
    }
    int i =0;


    final Map<String, dynamic> decodedResponse1 = jsonDecode(response.body);
    final Map<String, dynamic> decodedResponse = decodedResponse1['payload'];
    final getproductsList = decodedResponse['data'];
    setState(() {});
    print('Length is');
    print(getproductsList.length);

    for (i; i < getproductsList.length; i++) {
      print('length of this products');
     
        newPrice = (getproductsList[i]['fixed_price']!= null &&
                getproductsList[i]['fixed_price']> 0)
            ? (getproductsList[i]['fixed_price'] +
                (getproductsList[i]['additional_price'] ?? 0))
            : int.parse(getproductsList[i]['price'].toString());
        //  print(newPrice);
        setState(() {});
      
      print(newPrice);

      products.add(
        Product(
          vehicleName: getproductsList[i]['translate'][0]['title'],
          price: 10.toString(),
          newPrice: 20.toString(),
        ),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  myAskingPrice = false;
                });
              },
              child: Text("fixed price"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  myAskingPrice = true;
                });
              },
              child: Text("asking price"),
            ),
          ],
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2.0,
            ),
            itemCount: products.length,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: PracticeItem(
                  isAskingPrice: myAskingPrice,
                  vehiclaName: products[index].vehicleName.toString(),
                  price: products[index].price.toString(),
                  newPrice: products[index].newPrice.toString(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
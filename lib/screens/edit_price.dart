import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/screens/home_vehicle.dart';

class PriceEditScreen extends StatefulWidget {
  final String? name;
  final String? price;
  final String? purchase_price;
  final String? fixed_price;
  final String? registration;

  final int? id;

  const PriceEditScreen({
    super.key,
    this.name,
    this.price,
    this.purchase_price,
    this.fixed_price,
    this.registration,
    this.id,
  });

  @override
  State<PriceEditScreen> createState() => _PriceEditScreenState();
}

class _PriceEditScreenState extends State<PriceEditScreen> {
  TextEditingController _asking_PriceEditingController =
      TextEditingController();
  TextEditingController _purchase_PriceEditingcontroller =
      TextEditingController();
  TextEditingController _fixed_PriceEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //String n=widget.name.toString();

    _asking_PriceEditingController.text = widget.price.toString();
    _purchase_PriceEditingcontroller.text = widget.purchase_price.toString();
    _fixed_PriceEditingController.text = widget.fixed_price.toString();
  }

  bool updateDataInProgress = false;
  bool submitDataInProgress = false;

  void updateData() async {
    updateDataInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final id = widget.id;

    final body = {
      "purchase_price": _purchase_PriceEditingcontroller.text,
      "fixed_price": _fixed_PriceEditingController.text,
      "price": _asking_PriceEditingController.text,
    };

    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/$id/update";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/vnd.api+json',
      'Accept': 'application/vnd.api+json'
    });
    print(response.statusCode);
    updateDataInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.statusCode == 200) {
      _purchase_PriceEditingcontroller.clear();
      _fixed_PriceEditingController.clear();
      _asking_PriceEditingController.clear();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Price Update Succesfuly")));
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => HomeVehicle()),
      //     (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Price Update faild!!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black26,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Text(widget.name.toString(),
                  style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 50),
              Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Focused border color
                    ),
                  ),
                ),
                child: TextField(
                  controller: _asking_PriceEditingController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Asking Price",
                    labelStyle: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Focused border color
                    ),
                  ),
                ),
                child: TextField(
                  controller: _purchase_PriceEditingcontroller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Purchase Price",
                    labelStyle: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Focused border color
                    ),
                  ),
                ),
                child: TextField(
                  controller: _fixed_PriceEditingController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Fixed Price",
                    labelStyle: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Visibility(
                visible: updateDataInProgress == false,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          updateData();
                        },
                        child: Text("Price Update"))),
              )
            ],
          ),
        ));
  }
}

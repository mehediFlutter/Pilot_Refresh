import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/screens/home_vehicle.dart';

class EditScreen extends StatefulWidget {
  final String? name;
  final String? price;

  final int? id;

  const EditScreen({
    super.key,
    this.name,
    this.price,

    this.id,
  });

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _priceEditingController = TextEditingController();
  TextEditingController _registrationEditingController =
      TextEditingController();
  TextEditingController _manufactureEditingController = TextEditingController();
  TextEditingController _conditionEditingController = TextEditingController();
  TextEditingController _millegeEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //String n=widget.name.toString();
    _nameEditingController.text = widget.name.toString();
    _priceEditingController.text = widget.price.toString();

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
    "purchase_price":_priceEditingController.text
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
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Task Update Succesfuly")));
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => HomeVehicle()),
      //     (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Task Update faild!!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Your Task",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black26,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "Edit Price",
                style: TextStyle(color: Colors.white),
              ),
              Text("Name"),
              TextField(
                controller: _nameEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.black, border: OutlineInputBorder()),
              ),
              TextField(
                controller: _priceEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              TextField(
                controller: _registrationEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    prefix: Text(
                      "R :  ",
                      style: TextStyle(color: Colors.white),
                    ),
                    border: OutlineInputBorder()),
              ),
              TextField(
                controller: _conditionEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              TextField(
                controller: _millegeEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),
              SizedBox(height: 30),
              Visibility(
                visible: updateDataInProgress==false,
                replacement: Center(child: CircularProgressIndicator(),),
                child: SizedBox(
                    width: double.infinity,
                    child:
                        ElevatedButton(onPressed: () {
                          updateData();
                        }, child: Text("Update"))),
              )
            ],
          ),
        ));
  }
}

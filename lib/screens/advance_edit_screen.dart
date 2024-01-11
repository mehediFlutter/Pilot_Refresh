import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/screens/home_vehicle.dart';

class AdvanceScreen extends StatefulWidget {
  final String? name;
  final String? price;
  final String? purchase_price;
  final String? fixed_price;
  final String? registration;
  final String? manufacture;
  final String? condition;
  final String? mileage;
  final int? id;

  const AdvanceScreen({
    super.key,
    this.name,
    this.price,
    this.purchase_price,
    this.fixed_price,
    this.registration,
    this.manufacture,
    this.condition,
    this.mileage,
    this.id,
  });

  @override
  State<AdvanceScreen> createState() => _AdvanceScreenState();
}

class _AdvanceScreenState extends State<AdvanceScreen> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _priceEditingController = TextEditingController();
  TextEditingController _registrationEditingController =
      TextEditingController();
  TextEditingController _manufactureEditingController = TextEditingController();
  TextEditingController _conditionEditingController = TextEditingController();
  TextEditingController _millegeEditingController = TextEditingController();
  TextEditingController _controller = TextEditingController();
  String? _selectedItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //String n=widget.name.toString();
    _nameEditingController.text = widget.name.toString();
    _priceEditingController.text = widget.price.toString();
    _registrationEditingController.text = widget.registration.toString();
    _manufactureEditingController.text = widget.manufacture.toString();
    _conditionEditingController.text = widget.condition.toString();
    _millegeEditingController.text = widget.mileage.toString();
  }

  bool updateDataInProgress = false;
  bool submitDataInProgress = false;

  void updateData() async {
    updateDataInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final id = widget.id;

    final body = {"purchase_price": _priceEditingController.text};
    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/${widget.id}/update";
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

  List<String> _items = ['Option 1', 'Option 2', 'Option 3'];

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
                "Edit ",
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

              TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Drop Down Practice',
              suffixIcon: PopupMenuButton<String>(
                onSelected: (String value) {
                  setState(() {
                    _selectedItem = value;
                    _controller.text = value; // Update the text field
                  });
                },
                itemBuilder: (BuildContext context) {
                  return ['Option 1', 'Option 2', 'Option 3']
                      .map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ),
          ),

          InputDecorator(
            decoration: InputDecoration(
              labelText: 'Select an option',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.arrow_drop_down),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedItem,
                items: _items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedItem = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Text('Selected item: $_selectedItem'),
          SizedBox(height: 20),
          Text('Selected item: $_selectedItem'),
              SizedBox(height: 30),
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
                        child: Text("Update"))),
              )
            ],
          ),
        ));
  }
}

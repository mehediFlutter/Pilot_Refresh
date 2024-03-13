import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/screens/double_vehicle_screen.dart';
import 'package:pilot_refresh/screens/home_vehicle.dart';
import 'package:pilot_refresh/screens/bottom_nav_base-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late SharedPreferences preffs;
  String? purchasePrice;
  String? fixedPrice;

  @override
  void initState() {
    print(widget.fixed_price);
    

    _asking_PriceEditingController.text = widget.price.toString();
   // _purchase_PriceEditingcontroller.text = widget.purchase_price.toString();
  //  _fixed_PriceEditingController.text = widget.fixed_price.toString();
   initializingPricesValues();
  }

  initializingPricesValues() async{
   if(widget.purchase_price==null) {
    _purchase_PriceEditingcontroller.text= await purchasePrice??'1';

   };
   if( widget.fixed_price==null) {
    _fixed_PriceEditingController.text= await '0';

   }
   else{
    _fixed_PriceEditingController.text=widget.fixed_price??'1';
   }
  }

  bool updateDataInProgress = false;
  bool submitDataInProgress = false;

  void updateData() async {
    preffs = await SharedPreferences.getInstance();
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
    final response = await http.put(uri, body: jsonEncode(body),    headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization': 'Bearer ${preffs.getString('token')}'
      },);
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
        await  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BottomNavBaseScreen()), (route) => false);
  
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Price Update faild!!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.black26,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(widget.name.toString(),
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 25),
                // Asking Price
                             TextField(
                  controller: _asking_PriceEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Asking Price",
                    labelStyle: TextStyle(color: Colors.white,fontSize: 25),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .white), // Set default border color to white
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .white), // Set focused border color to white
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white, fontSize: 30),
                  //style: TextStyle(color: Colors.white,fontSize: 20),
                  cursorColor: Colors.white, // Set cursor color to white
                  //cursorHeight: 20,
                ),
                SizedBox(height: 20),
                            TextField(
                  controller: _purchase_PriceEditingcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Purchase Price",
                    labelStyle: TextStyle(color: Colors.white,fontSize: 25),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .white), // Set default border color to white
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .white), // Set focused border color to white
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white, fontSize: 30),
                  //style: TextStyle(color: Colors.white,fontSize: 20),
                  cursorColor: Colors.white, // Set cursor color to white
                  //cursorHeight: 20,
                ),
                // SizedBox(height: 10),
                // Theme(
                //   data: Theme.of(context).copyWith(
                //     inputDecorationTheme: InputDecorationTheme(
                //       border: OutlineInputBorder(
                //         borderSide: BorderSide(
                //             color: Colors.grey), // Default border color
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: BorderSide(
                //             color: Colors.white), // Focused border color
                //       ),
                //       contentPadding:
                //           EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                //     ),
                //   ),
                //   child: TextField(
                //     keyboardType: TextInputType.number,
                //     controller: _fixed_PriceEditingController,
                //     style: TextStyle(color: Colors.white, fontSize: 20),
                //     cursorColor: Colors.white,
                //     cursorHeight: 20,
                //     decoration: InputDecoration(
                //       labelText: "Fixed Price",
                //       labelStyle: Theme.of(context)
                //           .textTheme
                //           .titleSmall!
                //           .copyWith(fontSize: 15),
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                // New TextFild
                TextField(
                  controller: _fixed_PriceEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Fixed Price",
                    labelStyle: TextStyle(color: Colors.white,fontSize: 25),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .white), // Set default border color to white
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .white), // Set focused border color to white
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white, fontSize: 30),
                  //style: TextStyle(color: Colors.white,fontSize: 20),
                  cursorColor: Colors.white, // Set cursor color to white
                  //cursorHeight: 20,
                ),
                SizedBox(height: 20),
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
                          child: SizedBox(
                            height: 80,
                            child: Center(child: Text("Price Update",style: TextStyle(fontSize: 20),))))),
                )
              ],
            ),
          ),
        ));
  }
}

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pilot_refresh/widget/custom_text_fild.dart';

class TextFildSelectBox extends StatefulWidget {
  final int? id;
  final String? availableDD;
  final String? vehiclaName;

  const TextFildSelectBox(
      {Key? key, this.id, this.availableDD, this.vehiclaName})
      : super(key: key);

  @override
  State<TextFildSelectBox> createState() => _TextFildSelectBoxState();
}

class _TextFildSelectBoxState extends State<TextFildSelectBox> {
  customFormFild(String labelText, TextInputType keyboardType) {
    TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.white, fontSize: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white), // Set default border color to white
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.white), // Set focused border color to white
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      ),
    );
  }

  bool _availabilityInProgress = false;
  List<dynamic> availableList = []; // Store a list of dynamic objects
  String? availableValue; // Initialize as nullable
  TextEditingController titleController = TextEditingController();
  TextEditingController CategoryController = TextEditingController();
  int? previousSelectedId;

  @override
  void initState() {
    super.initState();
    getAvailability();
    if (widget.vehiclaName!.isNotEmpty)
      titleController.text = widget.vehiclaName ?? '--';
    // print("Car id is");
    // print(widget.id);
  }

  Future getAvailability() async {
    _availabilityInProgress = true;
    setState(() {});

    try {
      final response = await http.get(Uri.parse(
          'https://pilotbazar.com/api/merchants/vehicles/products/availables'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parsedData = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          availableList = parsedData;
          // Set initial value to 'On Shipment'
          availableValue = widget.availableDD ?? availableList[0].toString();
          availableSectedDropdownItem = availableList.firstWhere(
            (item) => item['translate'][0]['title'] == availableValue,
          );
        });
      } else {
        // Handle error if API request fails
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      _availabilityInProgress = false;
      setState(() {});
    }
  }

  void updateAdvance(int availableID, int index) async {
    final body = {
      "available_id": availableID,
    };
    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/${widget.id}/available";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/vnd.api+json',
      'Accept': 'application/vnd.api+json'
    });
    print(response.statusCode);
    print(widget.id);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print("Succesfully Update");
    }
  }

  Map<String, dynamic>? availableSectedDropdownItem;

  TextStyle textFildUpText = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontFamily: "Roboto",
  );

  Row textFildUpTextRow(String title, {String? star}) {
    return Row(
      children: [
        Text(title, style: textFildUpText),
        if (star != null)
          Text(
            star,
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textFildUpTextRow('Title in English', star: ' *'),
                  SizedBox(height: 8),
                  customTextField(controller: titleController),
                  SizedBox(height: 20),
                  // if (_availabilityInProgress)
                  //   CircularProgressIndicator()
                  // else
                  textFildUpTextRow('Category', star: ' *'),
                  customTextField(controller: CategoryController),
                  textFildUpTextRow('Available', star: ' *'),
                  _availabilityInProgress
                      ? CircularProgressIndicator()
                      : DropdownButtonFormField<String>(
                          dropdownColor: Colors.black,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          value: availableValue,
                          // here set an id of this availableValue in availableSectedDropdownItem
                          items: availableList.map((item) {
                            return DropdownMenuItem<String>(
                              value: item['translate'][0]['title'] as String,
                              child: Text(
                                item['translate'][0]['title'] as String,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              availableValue = newValue;
                              //if i change any value then set set an id of availableSectedDropdownItem if i do not change the value then set previous vlaibleValue's id
                              availableSectedDropdownItem =
                                  availableList.firstWhere(
                                (item) =>
                                    item['translate'][0]['title'] ==
                                    availableValue,
                              );
                            });
                          },
                        ),
                  ElevatedButton(
                    onPressed: () async {
                      print(availableSectedDropdownItem);
                      print('this is my coltroller text');
                      print(titleController.text);
                      print("this is car id");
                      print(widget.id);
                      // Now you can use selectedDropdownItem
                      final int? availableSelectedId =
                          availableSectedDropdownItem?['id'];

                      if (availableSelectedId != null) {
                        // Now you can use selectedId
                        updateAdvance(availableSelectedId, widget.id ?? 0);
                      } else {
                        // Handle the case where no item is selected
                        print('No item selected in DropdownButtonFormField.');
                        // You might want to show an error message, throw an error, or handle it in another way
                      }
                      print(widget.id);
                      print(availableSectedDropdownItem?['id']);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 97, 93, 90),
                    ),
                    child: Text("Submit",
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

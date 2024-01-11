import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TextFildSelectBox extends StatefulWidget {
  final int? id;
  const TextFildSelectBox({Key? key, this.id}) : super(key: key);

  @override
  State<TextFildSelectBox> createState() => _TextFildSelectBoxState();
}

class _TextFildSelectBoxState extends State<TextFildSelectBox> {
  customFormFild(String labelText,TextInputType keyboardType) {
    TextFormField(
      
      keyboardType: keyboardType,
      
      decoration:  InputDecoration(
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
  List<dynamic> dropDownList = []; // Store a list of dynamic objects
  String? selectedValue; // Initialize as nullable

  @override
  void initState() {
    super.initState();
    getAvailability();
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
          dropDownList = parsedData;
          selectedValue = parsedData.isNotEmpty
              ? parsedData[0]['translate'][0]['title']
              : null; // Set initial value
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
  Map<String, dynamic>? selectedDropdownItem;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          // backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                if (_availabilityInProgress)
                  CircularProgressIndicator()
                else
                  DropdownButtonFormField<String>(
                    // style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      
                      border: OutlineInputBorder(),
                    ),
                    value: selectedValue,
                    items: dropDownList.map((item) {
                      return DropdownMenuItem<String>(
                        value: item['translate'][0]['title']
                            as String, // Extract title
                        child: Text(item['translate'][0]['title'] as String),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue;
                        // Find the selected item in the dropDownList
                        selectedDropdownItem = dropDownList.firstWhere(
                          (item) =>
                              item['translate'][0]['title'] == selectedValue,
                        );
                      });
                    },
                  ),
                ElevatedButton(
                  onPressed: () async {
                    print("this is car id");
                    print(widget.id);
                    // Now you can use selectedDropdownItem
                    updateAdvance(selectedDropdownItem?['id'], widget.id ?? 0);
                    Navigator.pop(context);
                     print(widget.id);
                     print(selectedDropdownItem?['id']);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 97, 93, 90),
                  ),
                  child: Text("Submit", style: Theme.of(context).textTheme.bodySmall),
                 
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

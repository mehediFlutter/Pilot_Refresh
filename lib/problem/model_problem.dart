import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pilot_refresh/problem/model_products.dart';

class ModelProblem extends StatefulWidget {
  const ModelProblem({
    Key? key,
  }) : super(key: key);

  @override
  State<ModelProblem> createState() => _ModelProblemState();
}

class _ModelProblemState extends State<ModelProblem> {
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

  String title = 'Prado';
  bool _availabilityInProgress = false;
  List<dynamic> availableList = []; // Store a list of dynamic objects

  String? availableValue; // Initialize as nullable
  String? modelValue;

  Map<String, dynamic>? availableSectedDropdownItem;
  Map<String, dynamic>? modelSectedDropdownItem;

  @override
  void initState() {
    super.initState();
    getModel();
  }
List modelList = [];

Future<void> getModel() async {
  try {
    final response = await http.get(Uri.parse('https://pilotbazar.com/api/merchants/vehicles/colors'));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for (int i = 0; i < decodedResponse['payload'].length; i++) {
        List<Map<String, dynamic>> translateList = (decodedResponse['payload'][i]['translate'] as List<dynamic>)
            .cast<Map<String, dynamic>>();

        if (translateList.isNotEmpty) {
          modelList.add(ModelStore(
            colorr: 'abc',
            model: translateList[0]['title'] ?? 'None', colorId: 'df',
          ));
        }
      }

      setState(() {}); // If this is inside a StatefulWidget

      print('length of model List');
      print(modelList.length);
      print(modelList);
    } else {
      // Handle error if API request fails
      print('API request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching data: $error');
  } finally {
    _availabilityInProgress = false;
    setState(() {}); // If this is inside a StatefulWidget
  }
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Start Title English Textfild

                // Start Marchant Dropdown start

                customDropDownFormField(
                  value: modelValue,
                  list: modelList,
                  // onChanged: (newValue) {
                  //   setState(() {
                  //     title = newValue!;
                  //     modelSectedDropdownItem = modelList.firstWhere(
                  //       (item) => item['translate'][0]['title'] == title,
                  //     );
                  //   });
                  // },
                ),
                //  ElevatedButton(onPressed: (){}, child: )
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> customDropDownFormField({
    final String? value,
    final List? list,
    final Function(String? newValue)? onChanged,
  }) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      value: value,
      items: list?.map((item) {
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
      onChanged: onChanged,
    );
  }
}

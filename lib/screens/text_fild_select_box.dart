import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pilot_refresh/widget/custom_text_fild.dart';

class TextFildSelectBox extends StatefulWidget {
  final int? id;
  final String? availableDD;
  final String? conditionValue;
  final String? vehiclaName;
  final String? vehiclaNameBangla;
  final String? brandName;
  final String? fuel;
  final String? skeleton;
  final String? transmission;
  final String? registration;
  final String? model;
  final String? carColor;
  final String? edition;
  final String? grade;
  final String? carModel;
  final String? mileage;
  final String? engine;
  final String? purchase_price;
  final String? price;
  final String? fixed_price;

  const TextFildSelectBox({
    Key? key,
    this.id,
    this.availableDD,
    this.vehiclaName,
    this.vehiclaNameBangla,
    this.conditionValue,
    this.brandName,
    this.fuel,
    this.skeleton,
    this.transmission,
    this.registration,
    this.model,
    this.carColor,
    this.edition,
    this.grade,
    this.carModel,
    this.mileage,
    this.engine,
    this.purchase_price,
    this.price,
    this.fixed_price,
  }) : super(key: key);

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
  List<dynamic> conditionList = [];
  List<dynamic> skeletionList = [];
  List<dynamic> transmissionList = [];
  List<dynamic> registrationList = [];
  List<dynamic> colorList = [];
  List<dynamic> modelList = [];
  List<dynamic> gradeList = [];
  List<dynamic> myEditionList = [];

  String? availableValue; // Initialize as nullable
  String? conditionValue;
  String? fuelValue;
  String? skeletonValue;
  String? transmissionValue;
  String? registrationValue;
  String? colorValue;
  String? modelValue;
  String? gradeValue;
  String? myEditionValue;
  int negatiateId = 1;
  int appruvalId=1;
  int featuredId=1;
  int statusId=1;
  int? selectedRegistrationYear;
  int? selecteManufactureYear;

  TextEditingController titleControllerEnglish = TextEditingController();
  TextEditingController titleControllerBangla = TextEditingController();
  TextEditingController CategoryController = TextEditingController();
  TextEditingController mileagesController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController askingPriceController = TextEditingController();
  TextEditingController fixedPriceController = TextEditingController();
  int? previousSelectedId;
  List<dynamic> fuelList = [];
  List parseForFuel = [];

  Map<String, dynamic>? availableSectedDropdownItem;
  Map<String, dynamic>? conditionSectedDropdownItem;
  Map<String, dynamic>? fuelSectedDropdownItem;
  Map<String, dynamic>? skeletonSectedDropdownItem;
  Map<String, dynamic>? tarnsmissionSectedDropdownItem;
  Map<String, dynamic>? registrationSectedDropdownItem;
  Map<String, dynamic>? colorSectedDropdownItem;
  Map<String, dynamic>? ediSectedDropdownItem;
  Map<String, dynamic>? modelSectedDropdownItem;
  Map<String, dynamic>? gradeSectedDropdownItem;
  Map<String, dynamic>? myEditionSectedDropdownItem;
  Map<String, dynamic>? transmissionSelectedDropdownItem;

  @override
  void initState() {
    print('Model is');
    print(widget.model);

    super.initState();
    getAvailability();
    getConditions();
    getBrand(
      false,
      'https://pilotbazar.com/api/merchants/vehicles/brands',
    );
    getFuel(false, 'https://pilotbazar.com/api/merchants/vehicles/fuels');
    getSkeletitions();
    getRegistration();
    getColor();
    getGrade();
    getModel();
    getTransmission();
    print('color length');
    print(colorList.length);

    // getBrand(false, 'https://pilotbazar.com/api/merchants/vehicles/fuels');
    if (widget.vehiclaName!.isNotEmpty)
      titleControllerEnglish.text = widget.vehiclaName ?? '--';
    mileagesController.text = widget.mileage ?? '--';
    engineController.text = widget.engine ?? '--';
    purchasePriceController.text = '1000';
    askingPriceController.text = widget.price ?? '--';
    fixedPriceController.text = widget.fixed_price ?? '--';
    if (widget.vehiclaNameBangla!.isNotEmpty)
      titleControllerBangla.text = widget.vehiclaNameBangla ?? '--';
  }

  Future getAvailability() async {
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
  Future getModel() async {
    try {
      final response = await http.get(Uri.parse(
          'https://pilotbazar.com/api/merchants/vehicles/models'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parsedModelData = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          modelList = parsedModelData;
          // Set initial value to 'On Shipment'
          modelValue = widget.model ?? modelList[0].toString();
          modelSectedDropdownItem = modelList.firstWhere(
            (item) => item['translate'][0]['title'] == modelValue,
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

  Future getTransmission() async {
    try {
      final response = await http.get(Uri.parse(
          'https://pilotbazar.com/api/merchants/vehicles/transmissions/'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parsedTransmissionData =
            decodedResponse['payload'] as List<dynamic>;

        setState(() {
          transmissionList = parsedTransmissionData;
          // Set initial value to 'On Shipment'
          transmissionValue =
              widget.transmission ?? transmissionList[0].toString();
          transmissionSelectedDropdownItem = transmissionList.firstWhere(
            (item) => item['translate'][0]['title'] == transmissionValue,
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

  Future getGrade() async {
    try {
      final response = await http.get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/grades/'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final gradeParse = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          gradeList = gradeParse;
          // Set initial value to 'On Shipment'
          gradeValue = widget.grade ?? gradeList[0].toString();
          gradeSectedDropdownItem = gradeList.firstWhere(
            (item) => item['translate'][0]['title'] == gradeValue,
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

  Future getColor() async {
    try {
      final response = await http.get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/colors/'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parsedData = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          colorList = parsedData;
          print('length of colorList');
          print(colorList.length);
          // Set initial value to 'On Shipment'
          colorValue = widget.carColor ?? colorList[0].toString();
          colorSectedDropdownItem = colorList.firstWhere(
            (item) => item['translate'][0]['title'] == colorValue,
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

  Future<void> getEdition() async {
    try {
      final response = await http.get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/editions'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final myEditionParse = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          myEditionList = myEditionParse;
          print('length of My Edition');
          print(myEditionList.length);
          print(myEditionList);
          // Set initial value to 'FL Package'
          myEditionValue = widget.edition ??
              (myEditionList.isNotEmpty
                  ? myEditionList[0]['translate'][0]['title']
                  : null);
          myEditionSectedDropdownItem = myEditionList.firstWhere(
            (item) => item['translate'][0]['title'] == myEditionValue,
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
    }
  }

  Future modelPractice() async {
    _conditionInProgress = true;
    setState(() {});

    try {
      final response = await http.get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/models'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parseDataPractice = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          modelList = parseDataPractice;
          // Set initial value to 'On Shipment'
          modelValue = widget.model ?? modelList[0].toString();
          modelSectedDropdownItem = modelList.firstWhere(
            (item) => item['translate'][0]['title'] == modelValue,
          );
          print('map of Model');
          print(modelSectedDropdownItem);
          // print(conditionSectedDropdownItem?['id']);
        });
      } else {
        // Handle error if API request fails
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      _conditionInProgress = false;
      setState(() {});
    }
  }

  Future getRegistration() async {
    try {
      final response = await http.get(Uri.parse(
          'https://pilotbazar.com/api/merchants/vehicles/registrations'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parsedData = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          registrationList = parsedData;
          // Set initial value to 'On Shipment'
          registrationValue =
              widget.registration ?? registrationList[0].toString();
          registrationSectedDropdownItem = registrationList.firstWhere(
            (item) => item['translate'][0]['title'] == registrationValue,
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

  List<dynamic> brandList = [];
  String? brandValue;
  Map<String, dynamic>? brandSectedDropdownItem;

  Future getBrand(bool getBrandInProgress, String url) async {
    getBrandInProgress = true;
    setState(() {});

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final customParseData = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          brandList = customParseData;
          // Set initial value to 'On Shipment'
          brandValue = widget.brandName ?? brandList[0].toString();
          brandSectedDropdownItem = brandList.firstWhere(
            (item) => item['translate'][0]['title'] == brandValue,
          );
        });
      } else {
        // Handle error if API request fails
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      getBrandInProgress = false;
      setState(() {});
    }
  }

  // Future getTransmission(bool getBrandInProgress, String url) async {
  //   getBrandInProgress = true;
  //   setState(() {});

  //   try {
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       final decodedResponse = jsonDecode(response.body);
  //       final customParseData = decodedResponse['payload'] as List<dynamic>;

  //       setState(() {
  //         brandList = customParseData;
  //         // Set initial value to 'On Shipment'
  //         brandValue = widget.brandName ?? brandList[0].toString();
  //         brandSectedDropdownItem = brandList.firstWhere(
  //           (item) => item['translate'][0]['title'] == brandValue,
  //         );
  //       });
  //     } else {
  //       // Handle error if API request fails
  //       print('API request failed with status: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error fetching data: $error');
  //   } finally {
  //     getBrandInProgress = false;
  //     setState(() {});
  //   }
  // }

  Future getFuel(bool getBrandInProgress, String url) async {
    getBrandInProgress = true;
    setState(() {});

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final customParseData = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          fuelList = customParseData;
          // Set initial value to 'On Shipment'
          fuelValue = widget.fuel ?? fuelList[0].toString();
          fuelSectedDropdownItem = fuelList.firstWhere(
            (item) => item['translate'][0]['title'] == fuelValue,
          );
        });
      } else {
        // Handle error if API request fails
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      getBrandInProgress = false;
      setState(() {});
    }
  }

  Future customAvailable(bool getBrandInProgress, String url, List cParse,
      List custonList, String? value, Map<String, dynamic>? customMap) async {
    getBrandInProgress = true;
    setState(() {});

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        cParse = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          custonList = cParse;
          // Set initial value to 'On Shipment'
          value = value ?? custonList[0].toString();
          customMap = custonList.firstWhere(
            (item) => item['translate'][0]['title'] == value,
          );
        });
      } else {
        // Handle error if API request fails
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      getBrandInProgress = false;
      setState(() {});
    }
  }

  bool _conditionInProgress = false;
  Future getConditions() async {
    _conditionInProgress = true;
    setState(() {});

    try {
      final response = await http.get(Uri.parse(
          'https://pilotbazar.com/api/merchants/vehicles/conditions'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parsedDataCondition = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          conditionList = parsedDataCondition;
          // Set initial value to 'On Shipment'
          conditionValue = widget.conditionValue ?? conditionList[0].toString();
          conditionSectedDropdownItem = conditionList.firstWhere(
            (item) => item['translate'][0]['title'] == conditionValue,
          );
          print('map of conditions');
          print(conditionSectedDropdownItem);
          // print(conditionSectedDropdownItem?['id']);
        });
      } else {
        // Handle error if API request fails
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      _conditionInProgress = false;
      setState(() {});
    }
  }

  Future getSkeletitions() async {
    try {
      final response = await http.get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/skeletons'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parsedDataCondition = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          skeletionList = parsedDataCondition;
          // Set initial value to 'On Shipment'
          skeletonValue = widget.skeleton ?? skeletionList[0].toString();
          skeletonSectedDropdownItem = skeletionList.firstWhere(
            (item) => item['translate'][0]['title'] == skeletonValue,
          );
          print('map of conditions');
          print(skeletonSectedDropdownItem);
          // print(conditionSectedDropdownItem?['id']);
        });
      } else {
        // Handle error if API request fails
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      _conditionInProgress = false;
      setState(() {});
    }
  }

  Future myRegistration() async {
    try {
      final response = await http.get(Uri.parse(
          'https://pilotbazar.com/api/merchants/vehicles/registrations'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parsedDataCondition = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          registrationList = parsedDataCondition;
          // Set initial value to 'On Shipment'
          registrationValue = widget.registration ?? 'None';
          registrationSectedDropdownItem = registrationList.firstWhere(
            (item) => item['translate'][0]['title'] == registrationValue,
          );
          print('map of conditions');
          print(registrationSectedDropdownItem);
          // print(conditionSectedDropdownItem?['id']);
        });
      } else {
        // Handle error if API request fails
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      _conditionInProgress = false;
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

  SizedBox SzBx() => SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 40),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Start Title English Textfild
                    textFildUpTextRow('Title in English', star: ' *'),
                    customTextField(controller: titleControllerEnglish),
                    SzBx(),
                    //End Title English TextFild

                    //Start Title Bangla TextFild
                    textFildUpTextRow('Title in Bengali'),
                    customTextField(controller: titleControllerBangla),
                    SzBx(),
                    //End Title Bangla TextFild

                    // Start Marchant Dropdown start
                    textFildUpTextRow('Model', star: ' *'),
                    customDropDownFormField(
                      value: modelValue,
                     // list: modelList,
                    ),
                    SzBx(),
                    //End marchat dropdown

                    // Start Edition
                    textFildUpTextRow('Edition', star: ' *'),
                    customDropDownFormField(
                        //  value: myEditionValue,
                        // list: myEditionList,
                        //  list: xediList,
                        ),

                    //Start Brand Dropdown  *
                    textFildUpTextRow('Brand', star: ' *'),
                    customDropDownFormField(
                      value: brandValue,
                      list: brandList,
                      onChanged: (newValue) {
                        setState(() {
                          brandValue = newValue;
                          brandSectedDropdownItem = brandList.firstWhere(
                            (item) =>
                                item['translate'][0]['title'] == brandValue,
                          );
                        });
                      },
                    ),
                    SzBx(),
                    //End Brand dropdown

                    //Start Skeleton Dropdown
                    textFildUpTextRow('Skeleton or Body', star: ' *'),
                    customDropDownFormField(
                      value: skeletonValue,
                      list: skeletionList,
                      onChanged: (newValue) {
                        skeletonValue = newValue;
                        skeletonSectedDropdownItem = skeletionList.firstWhere(
                          (item) =>
                              item['translate'][0]['title'] == skeletonValue,
                        );
                      },
                    ),
                    SzBx(),

                    // End Skeleton Dropdown

                    // Start Color
                    textFildUpTextRow('Color', star: ' *'),
                    customDropDownFormField(
                      value: colorValue,
                      list: colorList,
                      onChanged: (newValue) {
                        setState(() {
                          colorValue = newValue;
                          colorSectedDropdownItem = colorList.firstWhere(
                            (item) =>
                                item['translate'][0]['title'] == colorValue,
                          );
                        });
                      },
                    ),
                    SzBx(),

                    //Start Transmission
                    textFildUpTextRow('Transmission', star: ' *'),
                    customDropDownFormField(
                      value: transmissionValue,
                      list: transmissionList,
                      onChanged: (newValue) {
                        setState(() {
                          transmissionValue = newValue;
                          transmissionSelectedDropdownItem =
                              transmissionList.firstWhere(
                            (item) =>
                                item['translate'][0]['title'] ==
                                transmissionValue,
                          );
                        });
                      },
                    ),

                    //Start Condition Dropdown *

                    // Start Grade
                    textFildUpTextRow('Grade', star: ' *'),
                    customDropDownFormField(
                      value: gradeValue,
                      list: gradeList,
                      onChanged: (newValue) {
                        setState(() {
                          gradeValue = newValue;
                          gradeSectedDropdownItem = gradeList.firstWhere(
                            (item) =>
                                item['translate'][0]['title'] == gradeValue,
                          );
                        });
                      },
                    ),

                    textFildUpTextRow('Condition', star: ' *'),
                    _conditionInProgress
                        ? CircularProgressIndicator()
                        : customDropDownFormField(
                            value: conditionValue,
                            list: conditionList,
                            onChanged: (newValue) {
                              setState(() {
                                conditionValue = newValue;
                                conditionSectedDropdownItem =
                                    conditionList.firstWhere(
                                  (item) =>
                                      item['translate'][0]['title'] ==
                                      conditionValue,
                                );
                              });
                            },
                          ),
                    SzBx(),
                    //End Condition Dropdown

                    SzBx(),
                    // End Edition

                    //Mileage DropDown Start
                    textFildUpTextRow('Mileage', star: ' *'),
                    customTextField(controller: mileagesController),
                    SzBx(),

                    textFildUpTextRow('Engine ', star: ' *'),
                    customTextField(controller: engineController),
                    SzBx(),

                    //Start Fuel Dropdown
                    textFildUpTextRow('Fuel', star: ' *'),
                    customDropDownFormField(
                      value: fuelValue,
                      list: fuelList,
                      onChanged: (newValue) {
                        fuelValue = newValue;
                        fuelSectedDropdownItem = fuelList.firstWhere(
                          (item) => item['translate'][0]['title'] == fuelValue,
                        );
                      },
                    ),
                    SzBx(),
                    // End Fuel Dropdown

                    // Start Registration
                    textFildUpTextRow('Registration'),
                    customDropDownFormField(
                      value: registrationValue,
                      list: registrationList,
                      onChanged: (newValue) {
                        registrationValue = newValue;
                        registrationSectedDropdownItem =
                            registrationList.firstWhere(
                          (item) =>
                              item['translate'][0]['title'] ==
                              registrationValue,
                        );
                      },
                    ),
                    SzBx(),

                    textFildUpTextRow('Available', star: ' *'),
                    _availabilityInProgress
                        ? CircularProgressIndicator()
                        : customDropDownFormField(
                            value: availableValue,
                            list: availableList,
                            onChanged: (newValue) {
                              setState(() {
                                availableValue = newValue;
                                availableSectedDropdownItem =
                                    availableList.firstWhere(
                                  (item) =>
                                      item['translate'][0]['title'] ==
                                      availableValue,
                                );
                              });
                            },
                          ),
                    SzBx(),
                    textFildUpTextRow('Purchase Price '),
                    customTextField(controller: purchasePriceController),
                    SzBx(),
                    textFildUpTextRow('Asking Price '),
                    customTextField(controller: askingPriceController),

                    SzBx(),
                    textFildUpTextRow('Fixed Price '),
                    customTextField(controller: fixedPriceController),
                    SzBx(),
                    textFildUpTextRow('Negotiable'),
                    customYesNoDropDownFormField(
                      value: negatiateId,
                      onChanged: (newValue) {
                        setState(() {
                          negatiateId = newValue!;
                        });
                        print('Selected ID: $newValue');
                      },
                    ),
                    textFildUpTextRow('Registration'),
                    customYearDropdownFormField(
  value: selectedRegistrationYear,
  onChanged: (newValue) {
    setState(() {
      selectedRegistrationYear = newValue;
    });
    print('Selected Year: $newValue');
  },
),
textFildUpTextRow('Manufacture'),
                    customYearDropdownFormField(
  value: selecteManufactureYear,
  onChanged: (newValue) {
    setState(() {
      selecteManufactureYear = newValue;
    });
    print('Selected Year: $newValue');
  },
),
textFildUpTextRow('Appruval'),
customAppruvalDropDownFormField(
                      value: appruvalId,
                      
                      onChanged: (newValue) {
                        setState(() {
                          appruvalId = newValue!;
                        });
                        print('Selected ID: $newValue');
                      },
                    ),
                    textFildUpTextRow('Featured',star: ' *'),
                    customYesNoDropDownFormField(
                      value: featuredId,
                      onChanged: (newValue) {
                        setState(() {
                          featuredId = newValue!;
                        });
                        print('Selected ID: $newValue');
                      },
                    ),
                    textFildUpTextRow('Status',star: ' *'),
                    customYesNoDropDownFormField(
                      value: statusId,
                      onChanged: (newValue) {
                        setState(() {
                          statusId = newValue!;
                        });
                        print('Selected ID: $newValue');
                      },
                    ),


                    ElevatedButton(
                      onPressed: () async {
                        print(availableSectedDropdownItem);
                        print('this is my coltroller text');
                        print(titleControllerEnglish.text);
                        print("this is car id");
                        print(widget.id);
                        // Now you can use selectedDropdownItem
                        final int? availableSelectedId =
                            availableSectedDropdownItem?['id'];
                        final int? conditionSelectedId =
                            conditionSectedDropdownItem?['id'];
                        final int? brandSelectedId =
                            brandSectedDropdownItem?['id'];
                        final int? skeletonSelectedId =
                            skeletonSectedDropdownItem?['id'];

                        final int? colorSelectedId =
                            colorSectedDropdownItem?['id'];
                        print("Available SElected id $availableSelectedId");
                        print("condition Selected Id $conditionSelectedId");
                        print("Brand Selected Id $brandSelectedId");
                        print("Skeleton Selected Id $skeletonSelectedId");
                        print("Negatiable value yes or no $negatiateId");
                        print("Selected Registration year is $selectedRegistrationYear");
                        print("Selected Manufacture year is $selecteManufactureYear");
                        print("Appruval id $appruvalId");
                        print("Featured Id is  $featuredId");
                        print("status is  Id is  $statusId");
                        // print(
                        //     "Registration Selected Id $registrationSelectedId");
                        print("Color Selected Id $colorSelectedId");

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
      //value: availableValue,
      value: value,
      items: list?.map((item) {
        return DropdownMenuItem<String>(
          //item['translate'][0]['title'] as String,
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

  DropdownButtonFormField<int> customYesNoDropDownFormField({
    final int? value,
    final Function(int? newValue)? onChanged,
  }) {
    return DropdownButtonFormField<int>(
      dropdownColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      value: value ?? 1, // Default to 1 (Yes) if value is not provided
      items: [
        DropdownMenuItem<int>(
          value: 1, // Yes
          child: Text(
            'Yes',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        DropdownMenuItem<int>(
          value: 0, // No
          child: Text(
            'No',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
  DropdownButtonFormField<int> customAppruvalDropDownFormField({
    final int? value,
    final Function(int? newValue)? onChanged,
  }) {
    return DropdownButtonFormField<int>(
      dropdownColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      value: value ?? 1, // Default to 1 (Yes) if value is not provided
      items: [
        DropdownMenuItem<int>(
          value: 1, // Yes
          child: Text(
            'Appruve',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        DropdownMenuItem<int>(
          value: 0, // No
          child: Text(
            'Pending',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }

DropdownButtonFormField<int?> customYearDropdownFormField({
  final int? value,
  final Function(int? newValue)? onChanged,
}) {
  List<int> years = List.generate(75, (index) => 2024 - index);

  return DropdownButtonFormField<int>(
    dropdownColor: Colors.black,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
    ),
    value: value,
    hint: Text(
      'Select Registration Year',
      style: TextStyle(color: Colors.white),
    ),
    items: [
      for (int year in years)
        DropdownMenuItem<int>(
          value: year,
          child: Text(
            year.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
    ],
    onChanged: onChanged,
  );
}

}

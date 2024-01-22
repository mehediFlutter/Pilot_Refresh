import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/advance/model_product.dart';
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
  final String? engine_number;
  final String? chassis_number;
  final String? code;
  final String? video;
  final String? manufacture;
  final String? engineId;
  final String? engines;
  final String? onlyMileage;

  const TextFildSelectBox(
      {Key? key,
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
      this.engine_number,
      this.chassis_number,
      this.code,
      this.video,
      this.manufacture,
      this.engineId,
      this.engines,
      this.onlyMileage})
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
  List<dynamic> conditionList = [];
  List<dynamic> skeletionList = [];
  List<dynamic> transmissionList = [];
  List<dynamic> registrationList = [];
  List<dynamic> colorList = [];
  List<dynamic> gradeList = [];

  List modelList = [];
  List parseModelData = [];

  List editionlList = [];
  List parseEditionData = [];

  String? availableValue; // Initialize as nullable
  String? conditionValue;
  String? fuelValue;
  String? skeletonValue;
  String? transmissionValue;
  String? registrationValue;
  String? colorValue;
  String? gradeValue;
  String? modelValue;
  String? editionValue;

  int negatiateId = 1;
  int appruvalId = 1;
  int featuredId = 1;
  int statusId = 1;
  int? selectedRegistrationYear;
  int? selecteManufactureYear;
  String? dateTime;

  TextEditingController titleControllerEnglish = TextEditingController();
  TextEditingController titleControllerBangla = TextEditingController();
  TextEditingController CategoryController = TextEditingController();
  TextEditingController mileagesController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController askingPriceController = TextEditingController();
  TextEditingController fixedPriceController = TextEditingController();
  TextEditingController engineNumberController = TextEditingController();
  TextEditingController chassisNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  TextEditingController manufactureController = TextEditingController();
  TextEditingController registrationController = TextEditingController();
  late TextEditingController dateAndTimeController;
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
  Map<String, dynamic>? gradeSectedDropdownItem;
  Map<String, dynamic>? transmissionSelectedDropdownItem;
  Map<String, dynamic>? modelSectedDropdownItem;
  Map<String, dynamic>? editionSectedDropdownItem;

  @override
  void initState() {
    print('Engine Id is ');
    print(widget.engineId);
    print('chassis number is');
    print(widget.chassis_number);

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
    getTransmission();
    // Model
    getModel();
    //Edition
    getEdition();

    print('color length');
    print(colorList.length);

    // getBrand(false, 'https://pilotbazar.com/api/merchants/vehicles/fuels');
    if (widget.vehiclaName!.isNotEmpty) modelValue = widget.model ?? '--';
    editionValue = widget.edition ?? '--';
    titleControllerEnglish.text = widget.vehiclaName ?? '--';
    mileagesController.text = widget.onlyMileage ?? '--';
    engineController.text = widget.engines ?? '--';
    purchasePriceController.text = '1000';
    askingPriceController.text = widget.price ?? '--';
    fixedPriceController.text = widget.fixed_price ?? '--';
    engineNumberController.text = widget.engine_number ?? '--';
    chassisNumberController.text = widget.chassis_number ?? '--';
    codeController.text = widget.code ?? '--';
    videoController.text = widget.video ?? '--';
    manufactureController.text = widget.manufacture ?? '--';
    registrationController.text = widget.registration ?? '--';
    if (widget.vehiclaNameBangla!.isNotEmpty)
      titleControllerBangla.text = widget.vehiclaNameBangla ?? '--';

    dateAndTimeController = TextEditingController(text: _getFormattedDate());
  }

  String _getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  _printDateAndTime() {
    DateTime now = DateTime.now();
    String selectedDate = dateAndTimeController.text;
    String formattedTime = DateFormat('hh:mm:ss a').format(now);

    print('Selected Date and Present Time: $selectedDate $formattedTime');

    // Store the combined date and time in the 'dateTime' variable
    dateTime = '$selectedDate $formattedTime';
    setState(() {});
    print('date time in a variable');
    print(dateTime);
  }

  bool editionInProgress = false;
  Future getEdition() async {
    editionInProgress = true;
    if (mounted) setState(() {});
    try {
      Response response = await get(
        Uri.parse('https://pilotbazar.com/api/merchants/vehicles/editions/'),
      );
      print(response.statusCode);
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for (int i = 0; i < decodedResponse['payload'].length; i++) {
        List<Map<String, dynamic>> translateList =
            (decodedResponse['payload'][i]?['translate'] as List<dynamic>?)
                    ?.cast<Map<String, dynamic>>() ??
                [];

        if (translateList.isNotEmpty) {
          editionlList.add(ModelProduct(name: translateList[0]['title']));
        } else {
          editionlList.add(ModelProduct(name: 'Default Title'));
        }
      }
      setState(() {
        parseEditionData = decodedResponse['payload'] as List<dynamic>;
        editionSectedDropdownItem = parseEditionData.firstWhere(
          (item) => item['translate'][0]['title'] == editionValue,
        );
        setState(() {});
      });
      for (var product in editionlList) {
        print('Name: ${product.name}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
    editionInProgress = false;
    if (mounted) setState(() {});
  }

  Future getModel() async {
    try {
      Response response = await get(
        Uri.parse('https://pilotbazar.com/api/merchants/vehicles/models/'),
      );
      print(response.statusCode);
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      for (int i = 0; i < decodedResponse['payload'].length; i++) {
        List<Map<String, dynamic>> translateList =
            (decodedResponse['payload'][i]?['translate'] as List<dynamic>?)
                    ?.cast<Map<String, dynamic>>() ??
                [];

        if (translateList.isNotEmpty) {
          modelList.add(ModelProduct(name: translateList[0]['title']));
        } else {
          modelList.add(ModelProduct(name: 'Default Title'));
        }
      }
      setState(() {
        parseModelData = decodedResponse['payload'] as List<dynamic>;
        modelSectedDropdownItem = parseModelData.firstWhere(
          (item) => item['translate'][0]['title'] == modelValue,
        );
        setState(() {});
      });
      for (var product in modelList) {
        print('Name: ${product.name}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
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

  Future getTransmission() async {
    try {
      final response = await http.get(Uri.parse(
          'https://pilotbazar.com/api/merchants/vehicles/transmissions/'));

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parsedData = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          transmissionList = parsedData;
          print('length of Transmission');
          print(transmissionList.length);
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

  Future updateAvailable(
      int brandId,
      editionId,
      conditionId,
      transmissionId,
      fuelId,
      skeletonId,
      mileage,
      price,
      fixedPrice,
      purchasePrice,
      availableId,
      registrationId,
      carModel,
      colorId,
      gradeId,
      String video,
      chassisNumber,
      engineNumber,
      code,
      engines,
      registration,
      manufacture,
      int is_appruval,
      String publish_at,
      int is_feat,
      status) async {
    final body = {
      "brand_id": brandId,
      "edition_id": editionId,
      "condition_id": conditionId,
      "transmission_id": transmissionId,
      "fuel_id": fuelId,
      "skeleton_id": skeletonId,
      "mileages": mileage,
      "price": price,
      "fixed_price": fixedPrice,
      "purchase_price": purchasePrice,
      "available_id": availableId,
      "registration_id": registrationId,
      "carmodel_id": carModel,
      "color_id": colorId,
      "grade_id": gradeId,
      "video": video,
      "chassis_number": chassisNumber,
      "engine_number": engineNumber,
      "code": code,
      "engines": engines,
      "registration": registration,
      "manufacture": manufacture,
      "is_approved": is_appruval,
      "publish_at": publish_at,
      "is_feat": is_feat,
      "status": status
    };
    final url = "https://pilotbazar.com/api/merchants/vehicles/products/12";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/vnd.api+json',
      'Accept': 'application/vnd.api+json'
    });
    print(response.statusCode);

    print(response.statusCode);

    if (response.statusCode == 200) {
      print("Succesfully Update");
      print("my advance is updated");
    }
  }

  SizedBox SzBx() => SizedBox(height: 20);

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

                    textFildUpTextRow('Condition', star: ' *'),
                    customDropDownFormField(
                      value: conditionValue,
                      list: conditionList,
                      onChanged: (newValue) {
                        setState(() {
                          conditionValue = newValue;
                          conditionSectedDropdownItem =
                              conditionList.firstWhere(
                            (item) =>
                                item['translate'][0]['title'] == conditionValue,
                          );
                        });
                      },
                    ),
                    SzBx(),

                    //End marchat dropdown

                    // Start Edition
                    textFildUpTextRow('Edition', star: ' *'),
                    editionInProgress
                        ? Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.blue,
                            ),
                          )
                        : custom_Model_Edition_DropDownFormField(
                            value: editionValue,
                            list: editionlList,
                            onChanged: (newValue) {
                              setState(() {
                                editionValue = newValue!;
                                editionSectedDropdownItem =
                                    parseEditionData.firstWhere(
                                  (item) =>
                                      item['translate'][0]['title'] ==
                                      editionValue,
                                );
                                setState(() {});
                              });
                            },
                          ),
                    SzBx(),
                    textFildUpTextRow('Mileage', star: ' *'),
                    customTextField(controller: mileagesController),
                    SzBx(),
                    textFildUpTextRow('Engines ', star: ' *'),
                    customTextField(controller: engineController),
                    SzBx(),
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
                    SzBx(),

                    // End Skeleton Dropdown

                    // Start Marchant Dropdown start
                    textFildUpTextRow('Model', star: ' *'),
                    custom_Model_Edition_DropDownFormField(
                      value: modelValue,
                      list: modelList,
                      onChanged: (newValue) {
                        setState(() {
                          modelValue = newValue!;
                          modelSectedDropdownItem = parseModelData.firstWhere(
                            (item) =>
                                item['translate'][0]['title'] == modelValue,
                          );
                          setState(() {});
                        });
                      },
                    ),

                    SzBx(),
                    //End Brand dropdown

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
                    textFildUpTextRow('Code', star: ' *'),
                    customTextField(controller: codeController),
                    SzBx(),

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

                    //End Condition Dropdown

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
                    textFildUpTextRow('Transmission'),
                    customDropDownFormField(
                      value: transmissionValue,
                      list: transmissionList,
                      onChanged: (newValue) {
                        transmissionValue = newValue;
                        transmissionSelectedDropdownItem =
                            registrationList.firstWhere(
                          (item) =>
                              item['translate'][0]['title'] ==
                              transmissionValue,
                        );
                      },
                    ),
                    SzBx(),
                    textFildUpTextRow('Manufacture', star: ' *'),
                    customTextField(controller: manufactureController),

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
                    SzBx(),
                    textFildUpTextRow('Engine Number'),
                    customTextField(controller: engineNumberController),
                    SzBx(),
                    textFildUpTextRow('Chassis Number'),
                    customTextField(controller: chassisNumberController),
                    SzBx(),

                    textFildUpTextRow('Registration'),
                    customTextField(controller: registrationController),
                    // textFildUpTextRow('Registration'),
                    // customYearDropdownFormField(
                    //   value: selectedRegistrationYear,
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       selectedRegistrationYear = newValue;
                    //     });
                    //     print('Selected Year: $newValue');
                    //   },
                    // ),
                    // SzBx(),
                    // textFildUpTextRow('Manufacture'),
                    // customYearDropdownFormField(
                    //   value: selecteManufactureYear,
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       selecteManufactureYear = newValue;
                    //     });
                    //     print('Selected Year: $newValue');
                    //   },
                    // ),
                    SzBx(),
                    textFildUpTextRow('Video'),
                    customTextField(controller: videoController),
                    SzBx(),
                    textFildUpTextRow('Published Date', star: ' *'),
                    TextField(
                      controller: dateAndTimeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        // labelText: 'Publish Date',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 10),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      cursorColor: Colors.white,
                      onTap: () async {
                        // Open date picker when the text field is tapped
                        DateTime? selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (selectedDate != null) {
                          setState(() {
                            dateAndTimeController.text =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                          });
                        }
                      },
                    ),

                    SzBx(),
                    textFildUpTextRow('Appruval', star: ' *'),
                    customAppruvalDropDownFormField(
                      value: appruvalId,
                      onChanged: (newValue) {
                        setState(() {
                          appruvalId = newValue!;
                        });
                        print('Selected ID: $newValue');
                      },
                    ),
                    SzBx(),
                    textFildUpTextRow('Featured', star: ' *'),
                    customYesNoDropDownFormField(
                      value: featuredId,
                      onChanged: (newValue) {
                        setState(() {
                          featuredId = newValue!;
                        });
                        print('Selected ID: $newValue');
                      },
                    ),
                    SzBx(),
                    textFildUpTextRow('Status', star: ' *'),
                    customYesNoDropDownFormField(
                      value: statusId,
                      onChanged: (newValue) {
                        setState(() {
                          statusId = newValue!;
                        });
                        print('Selected ID: $newValue');
                      },
                    ),
                    SzBx(),

                    ElevatedButton(
                      onPressed: () async {
                        await _printDateAndTime();
                        
                        print('this is on press function');
                        print(dateTime);
                        setState(() {});

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
                        final int? modelSelectedId =
                            modelSectedDropdownItem?['id'];
                        final int? editionSelectedId =
                            editionSectedDropdownItem?['id'];
                        final int? transmissionSelectedId =
                            transmissionSelectedDropdownItem?['id'];
                        final int? fuelSelectedId =
                            fuelSectedDropdownItem?['id'];
                        final int? registrationSelectedId =
                            registrationSectedDropdownItem?['id'];
                        final int? gradeSelectedId =
                            gradeSectedDropdownItem?['id'];
                        // dateTime=;
                        print("Available SElected id $availableSelectedId");
                        print("condition Selected Id $conditionSelectedId");
                        print("Brand Selected Id $brandSelectedId");
                        print("Skeleton Selected Id $skeletonSelectedId");
                        print("Negatiable value yes or no $negatiateId");
                        print(
                            "Selected Registration year is $selectedRegistrationYear");
                        print(
                            "Selected Manufacture year is $selecteManufactureYear");
                        print("Appruval id $appruvalId");
                        print("Featured Id is  $featuredId");
                        print("status is  Id is  $statusId");
                        print("ModelSelected Id  is  Id is  $modelSelectedId");
                        print("EditionSelected Id is  $editionSelectedId");
                        print("date Time is $dateTime");
                        print(
                            "transmission Selected Id is is $transmissionSelectedId");
                        print(
                            "Registration Selected Id is is $registrationSelectedId");
                        // print(
                        //     "Registration Selected Id $registrationSelectedId");
                        print("Color Selected Id $colorSelectedId");
                        print("Fuel Selected Id $fuelSelectedId");
                        print("Grade Selected Id $gradeSelectedId");

                        print(widget.id);
                        print(availableSectedDropdownItem?['id']);

                        // final body =  {
                        //   "brand_id": brandSelectedId,
                        //   "edition_id": editionSelectedId,
                        //   "condition_id": conditionSelectedId,
                        //   "transmission_id": transmissionSelectedId,
                        //   "fuel_id": fuelSelectedId,
                        //   "skeleton_id": skeletonSelectedId,
                        //   "mileages": mileagesController.text,
                        //   "price": askingPriceController.text,
                        //   "fixed_price": fixedPriceController.text,
                        //   "purchase_price": purchasePriceController.text,
                        //   "available_id": availableSelectedId,
                        //   "registration_id": registrationSelectedId,
                        //   "carmodel_id": modelSelectedId,
                        //   "color_id": colorSelectedId,
                        //   "grade_id": gradeSelectedId,
                        //   "video": videoController.text,
                        //   "chassis_number": chassisNumberController.text,
                        //   "engine_number": engineNumberController.text,
                        //   "code": codeController.text,
                        //   "engines": engineController.text,
                        //   "registration": registrationController.text,
                        //   "manufacture": manufactureController.text,
                        //   "is_approved": appruvalId,
                        //   "publish_at": "1-22-2024",
                        //   "is_feat": featuredId,
                        //   "status": statusId,
                        // };

                        // final url =
                        //     'https://pilotbazar.com/api/merchants/vehicles/products/12';
                        // final uri = Uri.parse(url);

                        // final response = await http.put(
                        //   uri,
                        //   body: jsonEncode(body),
                        // );

                        await updateAvailable(
                          brandSelectedId!,
                          editionSelectedId,
                          conditionSelectedId,
                          transmissionSelectedId,
                          fuelSelectedId,
                          skeletonSelectedId,
                          mileagesController.text,
                          askingPriceController.text,
                          fixedPriceController.text,
                          purchasePriceController.text,

                          availableSelectedId,
                          registrationSelectedId,
                          modelSelectedId,
                          colorSelectedId,
                          gradeSelectedId,
                          videoController.text,

                          chassisNumberController.text,
                          engineController.text,
                          codeController.text,
                          engineController.text,
                          registrationController.text,
                          manufactureController.text,
                          appruvalId,
                          //     manufacture,

                          // int is_appruval,
                          // String  publish_at,
                          //  int is_feat,
                          // status
                          dateTime ?? '',

                          featuredId,
                          statusId,
                        );
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

  DropdownButtonFormField<String?> custom_Model_Edition_DropDownFormField({
    final String? value,
    final List? list,
    final Function(String? newValue)? onChanged,
  }) {
    return DropdownButtonFormField<String?>(
      dropdownColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      value: value,
      items: list
          ?.whereType<ModelProduct>() // Filter only Product items
          .map<DropdownMenuItem<String?>>((item) {
        return DropdownMenuItem<String?>(
          value: item.name,
          child: Text(
            item.name ?? '',
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

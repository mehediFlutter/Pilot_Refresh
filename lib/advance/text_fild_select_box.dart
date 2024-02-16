import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/advance/model_product.dart';
import 'package:pilot_refresh/widget/custom_text_fild.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    this.onlyMileage,
  }) : super(key: key);

  @override
  State<TextFildSelectBox> createState() => _TextFildSelectBoxState();
}

class _TextFildSelectBoxState extends State<TextFildSelectBox> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  late SharedPreferences prefss;
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
    super.initState();

    setState(() {
      getAvailability();
    });
    setState(() {
      getConditions();
    });
    setState(() {
      getBrand(
        false,
        'https://pilotbazar.com/api/merchants/vehicles/brands',
      );
    });
    setState(() {
      getFuel(false, 'https://pilotbazar.com/api/merchants/vehicles/fuels');
    });
    setState(() {
      getSkeletitions();
    });
    setState(() {
      getRegistration();
    });
    setState(() {
      getColor();
    });
    setState(() {
      getGrade();
    });
    setState(() {
      getTransmission();
    });
    // Model
    setState(() {
      getModel();
    });

    //Edition
    setState(() {
      getEdition();
    });

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
    if (widget.vehiclaName!.isNotEmpty)
      titleControllerBangla.text = widget.vehiclaNameBangla ?? '--';

    dateAndTimeController = TextEditingController(text: _getFormattedDate());
  }
  // 'https://pilotbazar.com/api/merchants/vehicles/products/availables'

  Future getAvailabilityCustom(String url, List mainList, String value,
      widgetValue, Map dropDown) async {
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parsedData = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          mainList = parsedData;
          // Set initial value to 'On Shipment'
          value = widgetValue ?? mainList[0].toString();
          dropDown = mainList.firstWhere(
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
      _availabilityInProgress = false;
      setState(() {});
    }
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
    prefss = await SharedPreferences.getInstance();
    editionInProgress = true;
    if (mounted) setState(() {});
    try {
      Response response = await get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/editions/'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });
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
    prefss = await SharedPreferences.getInstance();
    try {
      Response response = await get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/models/'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });
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
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
          Uri.parse(
              'https://pilotbazar.com/api/merchants/vehicles/products/availables'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });

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
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/grades/'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });

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
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/colors/'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });

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
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
          Uri.parse(
              'https://pilotbazar.com/api/merchants/vehicles/transmissions/'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });

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
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
          Uri.parse(
              'https://pilotbazar.com/api/merchants/vehicles/registrations'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });

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
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization': 'Bearer ${prefss.getString('token')}'
      });

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
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization': 'Bearer ${prefss.getString('token')}'
      });

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
    prefss = await SharedPreferences.getInstance();
    getBrandInProgress = true;
    setState(() {});

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization': 'Bearer ${prefss.getString('token')}'
      });

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
    prefss = await SharedPreferences.getInstance();
    _conditionInProgress = true;
    setState(() {});

    try {
      final response = await http.get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/conditions'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });

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
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/skeletons'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });

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
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
          Uri.parse(
              'https://pilotbazar.com/api/merchants/vehicles/registrations'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });

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
   fontFamily: 'Axiforma'
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

  Future<void> updateAvailable(
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
    prefss = await SharedPreferences.getInstance();
    final url = "https://pilotbazar.com/api/merchants/vehicles/products/12";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    print(response.statusCode);

    print(response.statusCode);

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Advance Update Successful!!')));
      Navigator.pop(context);
    }
  }

  SizedBox SzBx() => SizedBox(height: 20);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //    backgroundColor: Color(0xFF666666),
          //   title: Text("Advance",),),

          backgroundColor: Colors.black,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 2, right: 2, top: 40),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Start Title English Textfild
                      textFildUpTextRow('Title in English', star: ' *'),
                      customTextField(
                        controller: titleControllerEnglish,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Value';
                          }
                          return null;
                        },
                      ),
                      SzBx(),
                      //End Title English TextFild

                      //Start Title Bangla TextFild
                      textFildUpTextRow('Title in Bengali'),
                      customTextField(controller: titleControllerBangla),
                      SzBx(),
                      //End Title Bangla TextFild

                      //Start Brand Dropdown  *
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //  Text('child 1',style: TextStyle(color: Colors.white),),
                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Brand', star: ' *'),
                                customDropDownFormField(
                                  value: brandValue,
                                  list: brandList,
                                  onChanged: (newValue) {
                                    setState(() {
                                      brandValue = newValue;
                                      brandSectedDropdownItem =
                                          brandList.firstWhere(
                                        (item) =>
                                            item['translate'][0]['title'] ==
                                            brandValue,
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
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
                                            item['translate'][0]['title'] ==
                                            conditionValue,
                                      );
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter This value';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //  Text('child 1',style: TextStyle(color: Colors.white),),
                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Mileage', star: ' *'),
                                customTextField(controller: mileagesController),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Engines ', star: ' *'),
                                customTextField(controller: engineController),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SzBx(),

                      // Fuel and Skeleton or body
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //  Text('child 1',style: TextStyle(color: Colors.white),),
                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Fuel', star: ' *'),
                                customDropDownFormField(
                                  value: fuelValue,
                                  list: fuelList,
                                  onChanged: (newValue) {
                                    fuelValue = newValue;
                                    fuelSectedDropdownItem =
                                        fuelList.firstWhere(
                                      (item) =>
                                          item['translate'][0]['title'] ==
                                          fuelValue,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Skeleton or Body',
                                    star: ' *'),
                                customDropDownFormField(
                                  value: skeletonValue,
                                  list: skeletionList,
                                  onChanged: (newValue) {
                                    skeletonValue = newValue;
                                    skeletonSectedDropdownItem =
                                        skeletionList.firstWhere(
                                      (item) =>
                                          item['translate'][0]['title'] ==
                                          skeletonValue,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SzBx(),
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

                      // End Skeleton Dropdown

                      // Start Marchant Dropdown start

                      SzBx(),
                      //End Brand dropdown

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //  Text('child 1',style: TextStyle(color: Colors.white),),
                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Color', star: ' *'),
                                customDropDownFormField(
                                  value: colorValue,
                                  list: colorList,
                                  onChanged: (newValue) {
                                    setState(() {
                                      colorValue = newValue;
                                      colorSectedDropdownItem =
                                          colorList.firstWhere(
                                        (item) =>
                                            item['translate'][0]['title'] ==
                                            colorValue,
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Code', star: ' *'),
                                customTextField(controller: codeController),
                              ],
                            ),
                          ),
                        ],
                      ),

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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //  Text('child 1',style: TextStyle(color: Colors.white),),
                          Expanded(
                            child: Column(
                              children: [
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
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Manufacture', star: ' *'),
                                customTextField(
                                    controller: manufactureController),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SzBx(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //  Text('child 1',style: TextStyle(color: Colors.white),),
                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Purchase Price '),
                                customTextField(
                                    controller: purchasePriceController),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Asking Price '),
                                customTextField(
                                    controller: askingPriceController),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // fixed price and negotiable

                      SzBx(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //  Text('child 1',style: TextStyle(color: Colors.white),),
                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Fixed Price '),
                                customTextField(
                                    controller: fixedPriceController),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Negotiable', star: ' *'),
                                customYesNoDropDownFormField(
                                  value: negatiateId,
                                  onChanged: (newValue) {
                                    setState(() {
                                      negatiateId = newValue!;
                                    });
                                    print('Selected ID: $newValue');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SzBx(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //  Text('child 1',style: TextStyle(color: Colors.white),),
                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Engine Number'),
                                customTextField(
                                    controller: engineNumberController),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Chassis Number'),
                                customTextField(
                                    controller: chassisNumberController),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SzBx(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //  Text('child 1',style: TextStyle(color: Colors.white),),
                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Registration'),
                                customTextField(
                                    controller: registrationController),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
                                textFildUpTextRow('Published Date', star: ' *'),
                                TextField(
                                  controller: dateAndTimeController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    // labelText: 'Publish Date',
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 10),
                                    border: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    disabledBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    errorBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  cursorColor: Colors.white,
                                  onTap: () async {
                                    // Open date picker when the text field is tapped
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );

                                    if (selectedDate != null) {
                                      setState(() {
                                        dateAndTimeController.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(selectedDate);
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SzBx(),

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

                      textFildUpTextRow('Video'),
                      customTextField(controller: videoController),
                      SzBx(),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //  Text('child 1',style: TextStyle(color: Colors.white),),
                          Expanded(
                            child: Column(
                              children: [
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
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          Expanded(
                            child: Column(
                              children: [
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
                              ],
                            ),
                          ),
                        ],
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

                      SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
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
                              print(
                                  "Available SElected id $availableSelectedId");
                              print(
                                  "condition Selected Id $conditionSelectedId");
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
                              print(
                                  "ModelSelected Id  is  Id is  $modelSelectedId");
                              print(
                                  "EditionSelected Id is  $editionSelectedId");
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
                              if (_formKey.currentState!.validate()) {}

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
                                dateTime ?? '',
                                featuredId,
                                statusId,
                              );
                            }
                          
                          
                          },
                      
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 20),
                          child: Text("Submit",
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
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
    FormFieldValidator<String>? validator,
  }) {
    return DropdownButtonFormField<String>(
      validator: validator,

       dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
        border: OutlineInputBorder(),
      ),
      //value: availableValue,
      value: value, style: TextStyle(fontSize: 14,fontFamily: 'Axiforma'),
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
        dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
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
       dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
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
        dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
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
        dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
        border: OutlineInputBorder(),
      ),
      value: value,style: TextStyle(fontSize: 14,fontFamily: 'Axiforma'),
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

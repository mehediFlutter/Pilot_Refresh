import 'dart:io';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/add%20car/description_page.dart';
import 'package:pilot_refresh/add%20car/diseable_border_color.dart';
import 'package:pilot_refresh/advance/model_product.dart';
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:pilot_refresh/screens/auth/login_model.dart';
import 'package:pilot_refresh/widget/custom_text_fild.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNewCar extends StatefulWidget {
  const AddNewCar({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewCar> createState() => _AddNewCarState();
}

class _AddNewCarState extends State<AddNewCar> {
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
  List<dynamic> transmissionList = [];
  List<dynamic> registrationList = [];
  List<dynamic> colorList = [];
  List<dynamic> gradeList = [];
  List<dynamic> skeletionList = [];
  List<dynamic> codeList = [];
  List<dynamic> brandList = [];

  List modelList = [];
  List parseModelData = [];
  List parseCodeData = [];

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
  String? codeValue;
  String? brandValue;

  int? negatiateId;

  int appruvalId = 1;
  int featuredId = 1;
  int statusId = 1;
  int categoryId = 1;
  int isFeat = 1;

  int? selectedRegistrationYear;
  int? selecteManufactureYear;
  String? dateTime;

  TextEditingController titleControllerEnglish = TextEditingController();
  TextEditingController titleControllerBangla = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController CategoryController = TextEditingController();
  TextEditingController mileagesController = TextEditingController();
  TextEditingController engineController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController askingPriceController = TextEditingController();
  TextEditingController fixedPriceController = TextEditingController();
  TextEditingController additionalPriceController = TextEditingController();
  TextEditingController engineNumberController = TextEditingController();
  TextEditingController chassisNumberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController videoController = TextEditingController();
  TextEditingController manufactureController = TextEditingController();
  TextEditingController registrationController = TextEditingController();
  TextEditingController priotyController = TextEditingController();
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
  Map<String, dynamic>? codeSectedDropdownItem;
  Map<String, dynamic>? brandSectedDropdownItem;

  List custom = [];
  List parsedDataColor = [];

  @override
  void initState() {
    super.initState();
    String a = '';
    // setState(() {
    //   getColor();
    // });
    String b = '';
    setState(() {
      getConditions();
    });
    setState(() {
      getEdition();
    });
    setState(() {
      getBrand();
    });
    setState(() {
      getColor();
    });
    setState(() {
      getFuel();
    });
    setState(() {
      getSkeletitions();
    });
    setState(() {
      getTransmission();
    });
    setState(() {
      getModel();
    });
    setState(() {
      getGrade();
    });
    setState(() {
      getAvailable();
    });
    // setState(() {
    //   getCode();
    // });
    setState(() {
      code();
    });
    setState(() {
      getRegistration();
    });

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
        final parsedDataSkeleton = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          skeletionList = parsedDataSkeleton;
          // Set initial value to 'On Shipment'

          print('map of Skeleton');
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

  Future getColor() async {
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
        Uri.parse('https://pilotbazar.com/api/merchants/vehicles/colors/'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        List parsedDataColor = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          colorList = parsedDataColor;
          print('length of colorList');
          print(colorList.length);
          // Set initial value to 'On Shipment'
          colorValue = colorList[0];
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
      setState(() {});
    }
  }

  Future getAvailable() async {
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
        Uri.parse(
            'https://pilotbazar.com/api/merchants/vehicles/products/availables'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        List parsedDataAvailable = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          availableList = parsedDataAvailable;
          print('length of available');
          print(availableList.length);
          // Set initial value to 'On Shipment'
          availableValue = availableList[0];
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
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        List parsedDataGrade = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          gradeList = parsedDataGrade;
          print('length of gradeList');
          print(gradeList.length);
          // Set initial value to 'On Shipment'
          gradeValue = gradeList[0];
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
      setState(() {});
    }
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
        },
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

  Future<void> code() async {
    try {
      prefss = await SharedPreferences.getInstance();
      Response response = await get(
        Uri.parse('https://pilotbazar.com/api/merchants/vehicles/codes/'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        },
      );
      print('API Response Status Code: ${response.statusCode}');

      Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      if (decodedResponse['status'] == 'Request was successful') {
        List<dynamic> codePayload = decodedResponse['payload'] ?? [];
        print("length of code List is");
        print(codePayload.length);
        print("Length of color inside of color list");
        List<dynamic> colorInsideColor = decodedResponse['payload'][0]['code'];
        print(colorInsideColor.length);

        codeList.clear();
        print("Code List length");
        print(codePayload.length); // Clear the list before populating it

        for (int i = 0; i < colorInsideColor.length; i++) {
          //  List<Map<String, dynamic>> codeListData = codePayload[0]['code']?.cast<Map<String, dynamic>>() ?? [];

          if (colorInsideColor.isNotEmpty) {
            // Assuming you have a ModelProduct with a 'name' property
            codeList.add(ModelProduct(name: colorInsideColor[i]['code']));
          } else {
            codeList.add(ModelProduct(name: 'Default Title'));
          }
        }

        setState(() {
          parseCodeData = codePayload;
          codeSectedDropdownItem = parseCodeData.firstWhere(
            (item) => item['code'][0]['code'] == colorValue,
            orElse: () => null,
          );
        });
      } else {
        print(
            'API Request was not successful. Status: ${decodedResponse['status']}');
      }
    } catch (error) {
      print('Error fetching data: $error');
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
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        List parsedDataTransmission =
            decodedResponse['payload'] as List<dynamic>;

        setState(() {
          transmissionList = parsedDataTransmission;
          print('length of Transmission');
          print(transmissionList.length);
          // Set initial value to 'On Shipment'
          transmissionValue = transmissionList[0];
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
      setState(() {});
    }
  }

  bool _conditionInProgress = false;
  Future getFuel() async {
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
        Uri.parse('https://pilotbazar.com/api/merchants/vehicles/fuels/'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        List parsedDataFuel = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          fuelList = parsedDataFuel;
          print('length of colorList');
          print(fuelList.length);
          // Set initial value to 'On Shipment'
          fuelValue = fuelList[0];
          fuelSectedDropdownItem = colorList.firstWhere(
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
      setState(() {});
    }
  }

  Future getConditions() async {
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
        Uri.parse('https://pilotbazar.com/api/merchants/vehicles/conditions'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        },
      );

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final parsedDataCondition = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          conditionList = parsedDataCondition;
          print('length of condition List');
          print(conditionList.length);
          // Set initial value to 'On Shipment'
          conditionValue = conditionList[0];
          conditionSectedDropdownItem = conditionList.firstWhere(
            (item) => item['translate'][0]['title'] == conditionValue,
          );
        });
      } else {
        // Handle error if API request fails
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      setState(() {});
    }
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
          },
          );
      print("Edition status code");
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

  Future getBrand() async {
    setState(() {});
    prefss = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
          Uri.parse('https://pilotbazar.com/api/merchants/vehicles/brands'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        final customParseData = decodedResponse['payload'] as List<dynamic>;

        setState(() {
          brandList = customParseData;
        });
      } else {
        // Handle error if API request fails
        print('API request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {}
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

  Row textFildUpDiseableTextRow(String title, {String? star}) {
    return Row(
      children: [
        Text(title,
            style: TextStyle(
              color: Color.fromARGB(255, 192, 186, 186),
            )),
        if (star != null)
          Text(
            star,
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  SizedBox SzBx() => SizedBox(height: 20);

  imageUpload() async {
    final body = {
      "title[en]": "Toyota Demo Car",
      "title[bn]": "Toyota Demo Car",
      "user_id": 2,
      "category_id": 1,
      "merchant_id": 1,
      "brand_id": 9,
      "condition_id": 5,
      "transmission_id": 4,
      "engines": 45643,
      "edition_id": 10,
      "fuel_id": 4,
      "skeleton_id": 7,
      "mileages": 9348,
      "manufacture": 2014,
      "is_feat": 1,
      "status": 1,
      "is_approved": 1,
      "publish_at": "2012-1-2",
      "code": "PS-098",
      "available_id": 4,
      "registration_id": 6,
      "carmodel_id": 6,
      "color_id": 3,
      "fixed_price": 943949,
      "price": 349349,
      "chassis_number": "dk3499"
    };

    final url = "https://pilotbazar.com/api/merchants/vehicles/products";
    final uri = Uri.parse(url);
    final request = await http.post(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/vnd.api+json',
      'Accept': 'application/vnd.api+json'
    });
    print(request.statusCode);
  }

  List<XFile> selectedImages = [];
  var resJson;
  Future<void> getImages() async {
    final pickedImages = await ImagePicker().pickMultiImage();
    setState(() {
      selectedImages = pickedImages;
    });
  }

  int? newLyAddedCarId;

  Future<void> onUploadImages(
      String titleEnglish,
      titleBangla,
      userId,
      categoryId,
      merchantId,
      conditionId,
      transmissionId,
      engines,
      editionId,
      fuelId,
      skeletonId,
      mileage,
      manufacture,
      is_feat,
      statusId,
      is_approved,
      publish_at,
      code,
      available_id,
      registration_id,
      carmodel_id,
      fixed_price,
      price,
      chassis_number,
      brand_id,
      color_id) async {
    print("Here is the data which i want to pass dynamically");
    print(titleBangla);
    print(titleEnglish);
    print(userId);
    print(categoryId);
    print("Marcent id pass");
    print(merchantId);
    print("marchen id end");
    print(conditionId);
    print(transmissionId);
    print(engines);
    print(fuelId);
    print(skeletonId);
    print(mileage);
    print(manufacture);
    print(is_feat);
    print(statusId);
    print(is_approved);
    print(publish_at);
    print(code);
    print(available_id);
    print(carmodel_id);
    print(fixed_price);
    print(price);
    print(chassis_number);
    print(brand_id);
    print(color_id);
    prefss = await SharedPreferences.getInstance();
    Map<String, String> formData = {
      'title[en]': titleEnglish,
      'title[bn]': titleBangla,
      'user_id': '2',
      'category_id': categoryId.toString(),
      'merchant_id': merchantId,
      'condition_id': conditionId,
      'transmission_id': transmissionId,
      'engines': engines,
      'edition_id': editionId.toString(),
      'fuel_id': fuelId.toString(),
      'skeleton_id': skeletonId.toString(),
      'mileages': mileage.toString(),
      'manufacture': manufacture.toString(),
      'is_feat': isFeat.toString(),
      'status': statusId.toString(),
      'is_approved': is_approved.toString(),
      'publish_at': publish_at.toString(),
      // code

      'code': code.toString(),
      'available_id': available_id.toString(),
      'registration_id': registration_id.toString(),
      'carmodel_id': carmodel_id.toString(),
      'fixed_price': fixed_price.toString(),
      'price': price.toString(),
      'chassis_number': chassis_number.toString(),
      'brand_id': brand_id.toString(),
      'color_id': color_id.toString(),
    };
    Map<String, String> headers = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    };
    if (selectedImages.isNotEmpty) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            "https://pilotbazar.com/api/merchants/vehicles/products",
          ),
          // Replace with your actual API URL
        );
        request.headers.addAll(headers);

        // Loop through each selected image
        for (XFile? imageFile in selectedImages) {
          if (imageFile != null) {
            final fileLength = await imageFile.length();

            request.files.add(
              http.MultipartFile(
                'image', // Adjust key based on your API
                await imageFile.readAsBytes().asStream(),
                fileLength,
                filename: imageFile.name, // Use XFile's name property
              ),
            );
          }
        }
        request.fields.addAll(formData);
        var response = await request.send();
        final responseData = await response.stream.bytesToString();

        Map decodedResponse = jsonDecode(responseData.toString());
        print("Return id is");
        print(decodedResponse['payload']);
        print(decodedResponse['payload']['id']);
        newLyAddedCarId = decodedResponse['payload']['id'];
        print("this is  response data");
        if (decodedResponse['status'] == "Request was successful") {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DescriptionPage(
                        newLyAddedCarId: newLyAddedCarId,
                      )));
        }
        //  print(responseData);
      } catch (error) {
        print(error);
      }
    }
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
              padding: const EdgeInsets.only(left: 2, right: 2, top: 40),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SzBx(),
                      textFildUpTextRow('Title in English', star: ' *'),
                      customTextField(
                        
                        controller: titleControllerEnglish,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter value';
                          }
                          return null;
                        },
                      ),
                      SzBx(),
                      textFildUpTextRow('Title in Bengali'),
                      customTextField(
                        controller: titleControllerBangla,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Value';
                          }
                          return null;
                        },
                      ),
                      SzBx(),
                      textFildUpTextRow('Brand', star: ' *'),
                      customDropDownFormField(
                        labelText: 'Please Select Brand....',
                        list: brandList,
                        onChanged: (newValue) {
                          setState(() {
                            brandValue = newValue;
                            brandSectedDropdownItem = brandList.firstWhere(
                              (item) =>
                                  item['translate'][0]['title'] == brandValue,
                            );
                            print(
                                'Brand id is${brandSectedDropdownItem?['id']}');
                          });
                        },
                      ),
                      SzBx(),
                      textFildUpTextRow('Category', star: ' *'),
                      categorySelect(
                        hintText: 'Please Select Category...',
                        onChanged: (newValue) {},
                      ),
                      SzBx(),
                      textFildUpTextRow('Color', star: ' *'),
                      customDropDownFormField(
                        labelText: 'Please Select Color...',
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Value';
                          }
                          return null;
                        },
                      ),
                      SzBx(),
                      textFildUpTextRow('Code', star: ' *'),
                      custom_Model_Edition_DropDownFormField(
                        hintText: 'Please select Code...',
                        list: codeList,
                        onChanged: (newValue) {
                          setState(() {
                            codeValue = newValue;
                            setState(() {});
                          });
                        },
                      ),

                      SzBx(),
                      textFildUpTextRow('Condition', star: ' *'),
                      customDropDownFormField(
                        labelText: 'Please Select Condition...',
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
                      textFildUpDiseableTextRow('Edition', star: ' *'),
                      custom_Model_Edition_DropDownFormField(
                        hintText: 'Please Select...',
                        // value: editionValue,
                        list: editionlList,
                        onChanged: (newValue) {
                          setState(() {
                            editionValue = newValue!;
                            editionSectedDropdownItem =
                                parseEditionData.firstWhere(
                              (item) =>
                                  item['translate'][0]['title'] == editionValue,
                            );
                            setState(() {});
                            print(editionSectedDropdownItem?['id']);
                          });
                        },
                      ),
                      SzBx(),
                      textFildUpTextRow('Registration'),
                      customDropDownFormField(
                        labelText: 'Please Select Registration...',
                        list: registrationList,
                        onChanged: (newValue) {
                          registrationValue = newValue;
                          registrationSectedDropdownItem =
                              registrationList.firstWhere(
                            (item) =>
                                item['translate'][0]['title'] ==
                                registrationValue,
                          );
                          print(registrationValue);
                          print('id ${registrationSectedDropdownItem?['id']}');
                        },
                      ),

                      SzBx(),
                      textFildUpTextRow('Mileage', star: ' *'),
                      customTextField(
                        controller: mileagesController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Value';
                          }
                          return null;
                        },
                      ),
                      SzBx(),

                      GestureDetector(
                        onTap: () {
                          getImages();
                        },
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 29, 28, 28),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (selectedImages.isNotEmpty)
                                Row(
                                  children: selectedImages
                                      .map((imageFile) => Image.file(
                                            File(imageFile.path),
                                            height: 100,
                                            width: 100,
                                          ))
                                      .toList(),
                                )
                              else
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.file_upload_sharp,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    Text(
                                      "Upload Image",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                      SzBx(),
                      textFildUpTextRow('Engine', star: ' *'),
                      customTextField(
                          controller: engineController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Value';
                            }
                            return null;
                          }),
                      SzBx(),
                      textFildUpTextRow('Fuel', star: ' *'),
                      customDropDownFormField(
                          labelText: 'Please Select Fuel...',
                          //  value: fuelValue,
                          list: fuelList,
                          onChanged: (newValue) {
                            setState(() {
                              fuelValue = newValue;
                              fuelSectedDropdownItem = fuelList.firstWhere(
                                (item) =>
                                    item['translate'][0]['title'] == fuelValue,
                              );
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Value';
                            }
                            return null;
                          }),
                      SzBx(),
                      textFildUpTextRow('Skeleton or Body', star: ' *'),
                      customDropDownFormField(
                          labelText: 'Please Select Skeleton...',
                          //  value: fuelValue,
                          list: skeletionList,
                          onChanged: (newValue) {
                            setState(() {
                              skeletonValue = newValue;
                              skeletonSectedDropdownItem =
                                  skeletionList.firstWhere(
                                (item) =>
                                    item['translate'][0]['title'] ==
                                    skeletonValue,
                              );
                            });
                            print("Skeleton Is");
                            print(skeletonSectedDropdownItem?['id']);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Value';
                            }
                            return null;
                          }),

                      SzBx(),
                      textFildUpTextRow('Transmission', star: ' *'),
                      customDropDownFormField(
                        labelText: 'Please Select Transmission...',
                        //  value: fuelValue,
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
                        hintText: 'Please select Model',
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Value';
                          }
                          return null;
                        },
                      ),
                      // SzBx(),
                      // textFildUpTextRow('Code', star: ' *'),
                      // customTextField(
                      //   controller: codeController,
                      //   hintText: "Enter Code",
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Enter Value';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      SzBx(),
                      textFildUpTextRow('Grade', star: ' *'),
                      customDropDownFormField(
                        labelText: 'Please Select Grade...',
                        //  value: fuelValue,
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
                      SzBx(),
                      textFildUpTextRow('Available', star: ' *'),
                      customDropDownFormField(
                        labelText: 'Please Select Available...',
                        //  value: fuelValue,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Value';
                          }
                          return null;
                        },
                      ),
                      SzBx(),
                      textFildUpTextRow('Registration', star: ' *'),
                      customTextField(
                        controller: registrationController,
                        hintText: 'Enter Registration',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Value';
                          }
                          return null;
                        },
                      ),
                      SzBx(),
                      textFildUpTextRow('Prioty', star: ' *'),
                      customTextField(
                        controller: priotyController,
                        hintText: 'Enter Prioty',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Value';
                          }
                          return null;
                        },
                      ),
                      SzBx(),
                      textFildUpTextRow('Video', star: ' *'),
                      customTextField(
                        controller: videoController,
                        hintText: 'Video',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Value';
                          }
                          return null;
                        },
                      ),
                      SzBx(),

                      SzBx(),
                      textFildUpTextRow('Asking Price', star: ' *'),
                      customTextField(
                          controller: askingPriceController,
                          hintText: 'Enter Asking Price',
                          keyboardType: TextInputType.number),
                      SzBx(),
                      textFildUpTextRow('Fixed Price', star: ' *'),
                      customTextField(
                          controller: fixedPriceController,
                          hintText: 'Enter Fixed Price',
                          keyboardType: TextInputType.number),

                      SzBx(),
                      textFildUpTextRow('Negotiable', star: ' *'),
                      customNegatiableDownFormField(
                        hintText: 'Please Select',
                        value: negatiateId,
                        onChanged: (newValue) {
                          setState(() {
                            negatiateId = newValue!;
                          });
                          print('Selected ID: $newValue');
                        },
                      ),
                      SzBx(),
                      textFildUpTextRow('Cover or Main Image'),
                      GestureDetector(
                        onTap: () {},
                        child: Container(),
                      ),
                      SzBx(),
                      textFildUpTextRow('Engine Number'),
                      customTextField(controller: engineController),
                      SzBx(),
                      textFildUpTextRow('Chassis Number'),
                      customTextField(controller: chassisNumberController),
                      SzBx(),
                      textFildUpTextRow('Registration'),
                      customTextField(controller: registrationController),
                      SzBx(),
                      textFildUpTextRow('Manufacture', star: ' *'),
                      customTextField(controller: manufactureController),
                      SzBx(),
                      // textFildUpTextRow('Approval', star: ' *'),
                      // customYesNo_Parameter_DropDownFormField(
                      //   text1: 'Appruve',
                      //   text2: 'Pending',
                      //   value: appruvalId,
                      //   onChanged: (newValue) {
                      //     setState(() {
                      //       appruvalId = newValue!;
                      //     });
                      //     print('Selected ID: $newValue');
                      //   },
                      // ),

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
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
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
                      textFildUpDiseableTextRow('Appruval', star: ' *'),
                      borderChangedColor(),
                      SzBx(),
                      textFildUpDiseableTextRow('Featured', star: ' *'),
                      borderChangedColor(),
                      SzBx(),
                      textFildUpDiseableTextRow('Status', star: ' *'),
                      borderChangedColor(),
                      SzBx(),
                      SizedBox(
                        height: 70,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            prefss = await SharedPreferences.getInstance();
                            await _printDateAndTime();
                            LoginModel userInfo =
                                await AuthUtility.getUserInfo();
                            print(
                                'dynamically merchent id ${userInfo.payload?.merchant?.id}');
                            //  LoginModel userInfo = await AuthUtility.getUserInfo();
                            // if (_formKey.currentState!.validate()) {
                            await _printDateAndTime();
                            final colorSelectedId =
                                colorSectedDropdownItem?['id'];
                            final conditionSelectedId =
                                conditionSectedDropdownItem?['id'];
                            final fuelSelectedId =
                                fuelSectedDropdownItem?['id'];
                            final skeletionSelectedId =
                                skeletonSectedDropdownItem?['id'];
                            final transmissionSelectedId =
                                transmissionSelectedDropdownItem?['id'];
                            final modelSelectedId =
                                modelSectedDropdownItem?['id'];
                            final gradeSelectedId =
                                gradeSectedDropdownItem?['id'];

                            final availableSelectedId =
                                availableSectedDropdownItem?['id'];

                            final editionSelectedId =
                                editionSectedDropdownItem?['id'];
                            setState(() {});

                            print('Color Selected Id is ${colorSelectedId}');
                            print(
                                'Condition Selected Id is ${conditionSelectedId}');
                            print('Fuel Selected Id is ${fuelSelectedId}');
                            print(
                                'Skeletion Selected Id is ${skeletionSelectedId}');
                            print(
                                'Transmission Selected Id is ${transmissionSelectedId}');
                            print('Model Selected Id is ${modelSelectedId}');
                            print('Grade Selected Id is ${gradeSelectedId}');
                            print(
                                'availableSelectedId Selected Id is ${availableSelectedId}');
                            print("Appruval is $appruvalId");
                            print("date Time is $dateTime");
                            print("Fetured id is $featuredId");
                            print('code Selected id is$codeValue');
                            print('status is id is$statusId');
                            print(codeValue);
                            print("Edition selected id is $editionSelectedId");
                            print("Here is my user info from Login model");
                            //    print(userInfo.payload!.merchant?.id);

                            print(userInfo.payload?.merchant?.id);
                            print(userInfo.payload?.token);

                            onUploadImages(
                                titleControllerEnglish.text,
                                titleControllerBangla.text,
                                2.toString(),
                                1.toString(),
                                userInfo.payload?.merchant?.id.toString(),
                                conditionSelectedId.toString(),
                                transmissionSelectedId.toString(),
                                engineController.text.toString(),
                                editionSelectedId.toString(),
                                fuelSelectedId.toString(),
                                skeletonSectedDropdownItem?['id'].toString(),
                                mileagesController.text.toString(),
                                manufactureController.text.toString(),
                                isFeat.toString(),
                                statusId.toString(),
                                appruvalId.toString(),
                                dateTime.toString(),
                                codeValue.toString(),
                                availableSelectedId.toString(),
                                registrationSectedDropdownItem?['id']
                                    .toString(),
                                modelSelectedId.toString(),
                                fixedPriceController.text.toString(),
                                askingPriceController.text.toString(),
                                chassisNumberController.text.toString(),
                                brandSectedDropdownItem?['id'].toString(),
                                colorSelectedId.toString());
                          },
                          //  },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              elevation: 20),
                          child: Text("Add this car",
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                      ),
                      SizedBox(height: 40),
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
    final String? labelText,
    FormFieldValidator<String>? validator,
  }) {
    return DropdownButtonFormField<String>(
      dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,

      validator: validator,
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
        border: OutlineInputBorder(),
      ),
      //value: availableValue,
      value: value, style: TextStyle(fontSize: 15),
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
    final String? labelText,
    final Function(int? newValue)? onChanged,
    FormFieldValidator? validator,
  }) {
    return DropdownButtonFormField<int>(
      dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      validator: validator,
      // menuMaxHeight: 500,
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
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

  DropdownButtonFormField<int> categorySelect({
    final int? value,
    final String? hintText,
    final Function(int? newValue)? onChanged,
    FormFieldValidator? validator,
  }) {
    return DropdownButtonFormField<int>(
      dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      validator: validator,
      // menuMaxHeight: 500,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
        border: OutlineInputBorder(),
      ),
      value: value ?? 1, // Default to 1 (Yes) if value is not provided
      items: [
        DropdownMenuItem<int>(
          value: 1, // Yes
          child: Text(
            'Car',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }

  DropdownButtonFormField<int> customNegatiableDownFormField({
    final int? value,
    final String? hintText,
    final Function(int? newValue)? onChanged,
    FormFieldValidator? validator,
  }) {
    return DropdownButtonFormField<int>(
      dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
        border: OutlineInputBorder(),
      ), // Default to 1 (Yes) if value is not provided
      items: [
        DropdownMenuItem<int>(
          value: 1, // Yes
          child: Text(
            'Negotiable',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        DropdownMenuItem<int>(
          value: 0, // No
          child: Text(
            'Fixed',
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
    final String? hintText,
    final Function(int? newValue)? onChanged,
    FormFieldValidator? validator,
  }) {
    return DropdownButtonFormField<int>(
      dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
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

  DropdownButtonFormField<int> customYesNo_Parameter_DropDownFormField({
    final int? value,
    final Function(int? newValue)? onChanged,
    final String? text1,
    final String? text2,
    FormFieldValidator<int>? validator,
    final bool? enabled,
  }) {
    return DropdownButtonFormField<int>(
      // dropdownColor: Colors.grey,
      // menuMaxHeight: 500,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: enabled == false
                ? Colors.grey
                : Theme.of(context).colorScheme.secondary,
            //  color: Colors.green, // Use for testing
          ),
        ),
        // disabledBorder: OutlineInputBorder(),
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
      ),
      value: value ?? 1, // Default to 1 (Yes) if value is not provided
      items: [
        DropdownMenuItem<int>(
          enabled: false,
          value: 1, // Yes
          child: Text(
            text1 ?? '',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        DropdownMenuItem<int>(
          enabled: false,
          value: 0, // No
          child: Text(
            text2 ?? '',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
      onChanged: null,
    );
  }

  DropdownButtonFormField<int?> customYearDropdownFormField({
    final int? value,
    final Function(int? newValue)? onChanged,
    FormFieldValidator<int>? validator,
  }) {
    List<int> years = List.generate(75, (index) => 2024 - index);

    return DropdownButtonFormField<int>(
      dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      validator: validator,
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
    final String? hintText,
    final List? list,
    final Function(String? newValue)? onChanged,
    FormFieldValidator<String>? validator,
  }) {
    return DropdownButtonFormField<String?>(
      dropdownColor: Color.fromARGB(255, 61, 59, 59),
      menuMaxHeight: 500,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
        contentPadding: EdgeInsets.fromLTRB(7, 15, 0, 15),
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

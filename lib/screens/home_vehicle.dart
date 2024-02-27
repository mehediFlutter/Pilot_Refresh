import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pilot_refresh/admin/asking_fixed_stockList.dart';
import 'package:pilot_refresh/product.dart';
import 'package:pilot_refresh/screens/advance_edit_screen.dart';
import 'package:pilot_refresh/screens/edit_price.dart';
import 'package:pilot_refresh/advance/text_fild_select_box.dart';
import 'package:pilot_refresh/screens/vehicle-details.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';
import 'package:pilot_refresh/widget/end_drawer.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeVehicle extends StatefulWidget {
  final String? token;
  const HomeVehicle({super.key, this.token});

  @override
  State<HomeVehicle> createState() => _HomeVehicleState();
}

class _HomeVehicleState extends State<HomeVehicle> {
  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
  //static String imagePath = "https://pilotbazar.com/storage/vehicles/";
  static late int page;
  static late int i;
  late SharedPreferences prefss;
  //static List allSearchProducts = [];
  static List newSearchProducts = [];
  String searchValue = '';
  bool searchInProgress = false;
  bool shareInProgress = false;
  late String toki;
  bool _isDeviceConnected = false;
  bool _isAlertShown = false;
  late StreamSubscription<ConnectivityResult> _subscription;

  int getIntPreef = 0;
  Future<void> getPreffs() async {
    prefss = await SharedPreferences.getInstance();
    if (prefss.getString('token') == null) {
      getIntPreef--;
    } else {
      getIntPreef++;
    }
  }

  @override
  initState() {
    _checkConnectivity();
    _listenForChanges();
    page = 1;
    initializePreffsBool();
    page = 1;
    i = 0;
    getProduct(page);
    _scrollController.addListener(_listenToScroolMoments);

    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        page = 1;
        i = 0;
        searchProducts.clear();
        products.clear();
        getProduct(page);
        setState(() {});
      }
      _listenToScroolMoments;
    });

    setState(() {});
  }

  @override
  void dispose() {
    _subscription.cancel(); // Cancel subscription on dispose
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    try {
      _isDeviceConnected = await InternetConnectionChecker().hasConnection;
      _showAlertDialogIfNeeded();
    } catch (e) {
      print("Error checking connectivity: $e");
    }
  }

  void _listenForChanges() {
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      try {
        _isDeviceConnected = await InternetConnectionChecker().hasConnection;
        _showAlertDialogIfNeeded();
      } catch (e) {
        print("Error listening for connectivity changes: $e");
      }
    });
  }

  void _showAlertDialogIfNeeded() {
    if (!_isDeviceConnected && !_isAlertShown) {
      _isAlertShown = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          elevation: 5,
          actionsPadding: EdgeInsets.all(5),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'No Internet Connection',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Axiforma'),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Please check your internet connection and",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontFamily: 'Axiforma'),
              ),
              Text(
                "try again",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                    fontFamily: 'Axiforma'),
              ),
            ],
          ),
          actions: [
            Divider(
              thickness: 1, // Adjust thickness as needed
              color: Colors.black26, // Adjust color as needed
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                _isAlertShown = false;
                await _checkConnectivity(); // Recheck after clicking OK
                initState();
              },
              child: Center(
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 17, fontFamily: 'Axiforma'),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  initializePreffsBool() async {
    await getPreffs();
    setState(() {
      print("get Int Preef");
      print(getIntPreef);
    });
  }

  static List allProductsForSearch = [];
  static List newProductsForSearch = [];

  // ... (rest of your existing code)
  int f = 1;
  void getProductForSearch() async {
    for (f; f < 14; f++) {
      Response response =
          await get(Uri.parse("https://pilotbazar.com/api/vehicle?page=$f"));
      //https://pilotbazar.com/api/vehicle?page=0
      //https://crud.teamrabbil.com/api/v1/ReadProduct
      print(response.statusCode);
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      print(decodedResponse['data']);
      for (int i = 0; i < decodedResponse['data'].length; i++) {
        allProductsForSearch.add(Product(
          vehicleName:
              decodedResponse['data'][i]?['translate'][0]['title'] ?? '',
          vehicleNameBangla:
              decodedResponse['data'][i]['translate'][1]?['title'] ?? "",
          manufacture: decodedResponse['data'][i]?['manufacture'] ?? '',
          slug: decodedResponse['data'][i]?['slug'] ?? '',
          id: decodedResponse['data'][i]['id'] ?? '',
          condition: decodedResponse['data'][i]?['condition']['translate'][0]
                  ?['title'] ??
              '',
          mileage: decodedResponse['data'][i]?['mileage']['translate'][0]
                  ?['title'] ??
              '',
          price: decodedResponse['data'][i]?['price'] ?? '',
          imageName: decodedResponse['data'][i]?['image']['name'] ?? '',
          registration: decodedResponse['data'][i]?['registration'] ?? '-',
        ));
      }
      setState(() {
        allProductsForSearch;
      });

      //print(allproducts.toString());
    }
  }

  void updateList(String val) {
    setState(() {
      searchValue = val; // Update the search term variable

      if (val.isNotEmpty) {
        newProductsForSearch = List.from(allProductsForSearch);
      } else {
        List<String> searchTerms = val.toLowerCase().split(' ');

        newProductsForSearch = allProductsForSearch.where((element) {
          String combinedText =
              '${element.vehicleName} ${element.manufacture}'.toLowerCase();

          // Check if all search terms are present in the combined text
          return searchTerms.every((term) => combinedText.contains(term));
        }).toList();
      }
    });
  }

  List products = [];

  bool _getProductinProgress = false;
  bool _getNewProductinProgress = false;
  bool _detailsInProgress = false;

  static int x = 0;
  void _listenToScroolMoments() {
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      page++;
      setState(() {});
      getNewProduct(page);

      if (mounted) {
        setState(() {});
      }
    }
  }

  void getNewProduct(int page) async {
    prefss = await SharedPreferences.getInstance();
    _getNewProductinProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response? response;
    if (prefss.getString('token') == null) {
      response = await get(
        Uri.parse(
            "https://pilotbazar.com/api/clients/vehicles/products?page=$page"),
      );
    } else {
      response = await get(
        Uri.parse(
            "https://pilotbazar.com/api/merchants/vehicles/products?page=$page"),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}',
        },
      );
    }
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse1 = jsonDecode(response.body);
    final Map<String, dynamic> decodedResponse = decodedResponse1['payload'];
    if (decodedResponse['data'].isEmpty) {
      _getNewProductinProgress = false;
      if (mounted) {
        setState(() {});
      }
    }

    if (response.statusCode == 200) {
      decodedResponse['data'].forEach((e) {
        products.add(Product(
          vehicleName: e['translate'][0]['title'],
          vehicleNameBangla: e['translate'][1]['title'],
          id: e['id'],
          slug: e['slug'] ?? '',
          manufacture: e['manufacture'] ?? '',
          condition: e['condition']['translate'][0]?['title'] ?? '',
          mileage: e['mileage']?['translate'][0]?['title'].toString() ??
              e['mileages'].toString() ??
              '--',
          price: e['price'].toString(),
          purchase_price: e['purchase_price'].toString() ?? '',
          fixed_price: e['fixed_price'].toString() ?? '',
          imageName: e['image']?['name'] ?? '',
          registration: e['registration'] ?? 'None',
          engine: e['engine']?['translate'][0]?['title'].toString() ?? '',
          brandName: e['brand']?['translate'][0]?['title'] ?? '',
          transmission: e['transmission']?['translate'][0]?['title'] ?? '',
          fuel: e['fuel']?['translate'][0]?['title'] ?? '',
          skeleton: e['skeleton']?['translate'][0]?['title'] ?? '',
          available: e['available']?['translate'][0]?['title'] ?? '',
          code: e['code'].toString() ?? '',
          carColor: e['color']['translate'][0]['title'] ?? 'None',
          edition: e['edition']['translate'][0]['title'] ?? 'None',
          model: e['carmodel']?['translate'][0]?['title'] ?? '',
          grade: e['grade']?['translate'][0]?['title'] ?? 'none',
          engineNumber: e['engine_number'].toString() ?? '--',
          chassisNumber: e['chassis_number'].toString() ?? '--',
          video: e['video'] ?? 'No Video',
          engine_id: e['engine_id'].toString() ?? '--',
          onlyMileage: e['mileages'].toString() ?? '--',
          engines: e['engines'].toString() ?? '-',
        ));
      });

      x = j + 1;
    }
    _getNewProductinProgress = false;
    if (mounted) {
      setState(() {});
    }
    print("Page Number is");
    print(page);
  }

  bool isLoading = false;
  @override
  getProduct(int page) async {
    prefss = await SharedPreferences.getInstance();
    products.clear();
    _getProductinProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response? response;
    if (prefss.getString('token') == null) {
      response = await get(
        Uri.parse(
            "https://pilotbazar.com/api/clients/vehicles/products?page=$page"),
      );
    } else {
      response = await get(
        Uri.parse(
            "https://pilotbazar.com/api/merchants/vehicles/products?page=$page"),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}',
        },
      );
    }
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse1 = jsonDecode(response.body);
    final Map<String, dynamic> decodedResponse = decodedResponse1['payload'];

    if (mounted) {
      setState(() {});
    }

    for (i; i < decodedResponse['data'].length; i++) {
      products.add(Product(
        vehicleName: decodedResponse['data'][i]['translate'][0]['title'],
        vehicleNameBangla: decodedResponse['data'][i]['translate'][1]['title'],
        manufacture: decodedResponse['data'][i]['manufacture'],
        slug: decodedResponse['data'][i]['slug'],
        id: decodedResponse['data'][i]['id'],
        condition: decodedResponse['data'][i]['condition']['translate'][0]
            ['title'],
        mileage: decodedResponse['data'][i]['mileage']?['translate'][0]
                ?['title'] ??
            '--',
        //price here
        price: decodedResponse['data'][i]['price'].toString() ?? '',
        purchase_price:
            decodedResponse['data'][i]?['purchase_price'].toString() ?? '',
        fixed_price:
            decodedResponse['data'][i]?['fixed_price'].toString() ?? '',
        //price end
        imageName: decodedResponse['data'][i]['image']['name'],
        registration: decodedResponse['data'][i]['registration'] ?? 'None',
        engine: decodedResponse['data'][i]['engine']?['translate'][0]['title']
                .toString() ??
            decodedResponse['data'][i]['engines'],
        brandName: decodedResponse['data'][i]['brand']['translate'][0]['title'],
        transmission: decodedResponse['data'][i]['transmission']['translate'][0]
            ['title'],
        fuel: decodedResponse['data'][i]['fuel']['translate'][0]['title'],
        skeleton: decodedResponse['data'][i]['skeleton']['translate'][0]
            ['title'],
        available: decodedResponse['data'][i]?['available']?['translate'][0]
                ?['title'] ??
            '',
        code: decodedResponse['data'][i]?['code'].toString() ?? '',
        //model: decodedResponse['data'],
        carColor: decodedResponse['data'][i]['color']?['translate'][0]
                ['title'] ??
            'None',
        edition: decodedResponse['data'][i]['edition']['translate'][0]
                ['title'] ??
            'None',
        model: decodedResponse['data'][i]?['carmodel']?['translate'][0]
                ?['title'] ??
            '',

        grade: decodedResponse['data'][i]?['grade']?['translate'][0]
                ?['title'] ??
            'none',
        engineNumber:
            decodedResponse['data'][i]['engine_number'].toString() ?? '--',
        chassisNumber:
            decodedResponse['data'][i]['chassis_number'].toString() ?? '--',
        video: decodedResponse['data'][i]?['video'] ?? 'No Video',
        engine_id: decodedResponse['data'][i]?['engine_id'].toString() ?? '12',
        onlyMileage: decodedResponse['data'][i]['mileages'].toString() ?? '--',
        engines: decodedResponse['data'][i]?['engines'].toString() ?? '-',
      ));
    }
    if (decodedResponse['data'] == null) {
      return;
    }
    _getProductinProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  bool _getDataInProgress = false;
  static List unicTitle = [];
  static List details = [];
  static List imageLInk = [];

  // Future getDetails(int id) async {
  //   _getDataInProgress = true;
  //   if (mounted) {
  //     setState(() {});
  //   }
  //   Response response = await get(Uri.parse(
  //       "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"));
  //   //https://pilotbazar.com/api/vehicle?page=0
  //   //https://crud.teamrabbil.com/api/v1/ReadProduct
  //   print(response.statusCode);
  //   final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
  //   List<dynamic> vehicleFeatures =
  //       decodedResponse['payload']['vehicle_feature'];

  //   List<FeatureDetailPair> featureDetailPairs =
  //       extractFeatureDetails(vehicleFeatures);

  //   for (var pair in featureDetailPairs) {
  //     unicTitle.add(pair.featureTitle);
  //     details.add(pair.detailTitles.join(', '));
  //   }

  //   // get image link in list

  //   _getDataInProgress = false;
  //   if (mounted) {
  //     setState(() {});
  //   }

  //   //return unicTitle+details;
  // }

  Future getDetails(int id) async {
    prefss = await SharedPreferences.getInstance();

    _getDataInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Response response = await get(
        Uri.parse(
            "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        });
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print("Get Details methodes");
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    List<dynamic> vehicleFeatures =
        decodedResponse['payload']['vehicle_feature'];

    List<FeatureDetailPair> featureDetailPairs =
        extractFeatureDetails(vehicleFeatures);

    for (var pair in featureDetailPairs) {
      unicTitle.add(pair.featureTitle);
      details.add(pair.detailTitles.join(', '));
    }
    _getDataInProgress = false;
    if (mounted) {
      setState(() {});
    }
    for (int y = 0; y < unicTitle.length; y++) {
      print(
        unicTitle[y],
      );
      print(
        details[y],
      );
    }
  }

  Future<void> shareMedia(String ImageName, vehicleName, manufacture, condition,
      registration, mileage, price, detailsLink) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }
    //setState() {});
    final uri = Uri.parse("https://pilotbazar.com/storage/vehicles/$ImageName");
    final response = await http.get(uri, headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    final imageBytes = response.bodyBytes;
    final tempDirectory = await getTemporaryDirectory();
    final tempFile =
        await File('${tempDirectory.path}/sharedImage.jpg').create();
    await tempFile.writeAsBytes(imageBytes);

    //await getDetails(widget.id);
    final image = XFile(tempFile.path);
    late String info;

    String message =
        "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage,price:$price ";

    if (unicTitle.length != 0) {
      info = "\n${unicTitle[0]} : ${details[0]}";
      _detailsInProgress = true;
      setState(() {});
      for (int b = 1; b < unicTitle.length; b++) {
        info += "\n${unicTitle[b]} : ${details[b]}";
      }
    }
    await Share.shareXFiles([image],
        text: _detailsInProgress ? message + info : message);
    //"Vehicle Name: ${products[x].vehicleName} \nManufacture:  ${products[x].manufacture} \nConditiion: ${products[x].condition} \nRegistration: ${products[x].registration} \nMillage: ${products[x].mileage}, \nPrice: ${products[x].price} \nOur HotLine Number: 017xxxxxxxx\n"
    unicTitle.clear();
    details.clear();
    _detailsInProgress = false;
    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
    setState(() {});
  }

  static String? detailsLink;
  bool imageInProgress = false;

  Future getLink(int id) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    print("get Link start bool ${imageInProgress}");

    prefss = await SharedPreferences.getInstance();

    print("This is get Link methode");
    prefss = await SharedPreferences.getInstance();
    Response? response1;
    if (prefss.getString('token') == null) {
      response1 = await get(
        Uri.parse(
            "https://pilotbazar.com/api/clients/vehicles/products/$id/detail"),
      );
    } else {
      response1 = await get(
          Uri.parse(
              "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });
    }
    final Map<String, dynamic> decodedResponse1 = jsonDecode(response1.body);
    detailsLink = decodedResponse1['message'];
    print(detailsLink);
    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
    print("get details end bool ${imageInProgress}");
  }

  static List showImageList = [];
  late String ImageLink;
  late List ImageLinkList = [];
  bool _shareAllImageInProgress = false;

  Future<void> sendAllImages(int id) async {
    shareInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    _shareAllImageInProgress = true;
    Response? response1;
    try {
      if (prefss.getString('token') == null) {
        response1 = await get(
          Uri.parse(
              "https://pilotbazar.com/api/clients/vehicles/products/$id/detail"),
        );
      } else {
        response1 = await get(
            Uri.parse(
                "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"),
            headers: {
              'Accept': 'application/vnd.api+json',
              'Content-Type': 'application/vnd.api+json',
              'Authorization': 'Bearer ${prefss.getString('token')}'
            });
      }
      print(response1?.statusCode);
      final Map<String, dynamic> decodedResponse1 = jsonDecode(response1!.body);

      for (int b = 0; b < decodedResponse1['payload']['gallery'].length; b++) {
        ImageLink = decodedResponse1['payload']["gallery"][b]?['name'] ?? '';
        ImageLinkList.add(ImageLink);
      }

      print("From List Image Links are");
      for (int c = 0; c < ImageLinkList.length; c++) {
        print(ImageLinkList[c]);
      }

      List<XFile> showImageList = [];
      for (int y = 0; y < ImageLinkList.length; y++) {
        final uri = Uri.parse(
            "https://pilotbazar.com/storage/galleries/${ImageLinkList[y]}");
        final response = await http.get(uri);
        final imageBytes = response.bodyBytes;
        final tempDirectory = await getTemporaryDirectory();
        print("hello");
        final tempFile = await File('${tempDirectory.path}/sharedImage$y.jpg')
            .writeAsBytes(imageBytes);

        final image = XFile(tempFile.path);
        showImageList.add(image);
      }

      print("Length is Unic title");
      print(unicTitle.length);
      late String info;

      if (showImageList.isNotEmpty) {
        // Share all images with text
        await Share.shareXFiles(
          showImageList.map((image) => image as XFile).toList(),
        );

        // Clear lists and reset state
        unicTitle.clear();
        details.clear();
        ImageLinkList.clear();
        showImageList.clear();
        shareInProgress = false;
        if (mounted) {
          setState(() {});
        }
      } else {
        print("No images to share.");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> shareDetailsWithOneImage(int id, String ImageName, vehicleName,
      manufacture, condition, registration, mileage, price, detailsLink) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }
    //setState() {});
    final uri = Uri.parse("https://pilotbazar.com/storage/vehicles/$ImageName");
    final response = await http.get(uri, headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    final imageBytes = response.bodyBytes;
    final tempDirectory = await getTemporaryDirectory();
    final tempFile =
        await File('${tempDirectory.path}/sharedImage.jpg').create();
    await tempFile.writeAsBytes(imageBytes);

    //await getDetails(widget.id);
    final image = XFile(tempFile.path);
    late String info;

    String message =
        "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage,price:$price ";
    print("length of unit title");
    print(unicTitle.length);
    String message2 = '';
    for (int i = 0; i < details.length; i++) {
      message2 += " ${details[i]}";
      if (i < details.length - 1) {
        message2 += ", "; // Add a comma and space if it's not the last index
      }
    }
    print(message2);
    String message3 =
        "\n\nOur HotLine Number: 0196-99-444-00\n Show More\n $detailsLink";
    //  info = "\n${unicTitle[0]} : ${details[0]}";
    //   _detailsInProgress = true;
    setState(() {});
    // for (int b = 1; b < unicTitle.length; b++) {
    //   info += "\n${unicTitle[b]} : ${details[b]}";
    // }

    await Share.shareXFiles([image], text: message + message2 + message3);
    //"Vehicle Name: ${products[x].vehicleName} \nManufacture:  ${products[x].manufacture} \nConditiion: ${products[x].condition} \nRegistration: ${products[x].registration} \nMillage: ${products[x].mileage}, \nPrice: ${products[x].price} \nOur HotLine Number: 017xxxxxxxx\n"
    unicTitle.clear();
    details.clear();

    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  // only details share
  Future<void> shareDetails(int id, String ImageName, vehicleName, manufacture,
      condition, registration, mileage, price, detailsLink) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }

    String message =
        "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage,price:$price ";
    print("length of unit title");
    print(unicTitle.length);
    String message2 = '';
    for (int i = 0; i < details.length; i++) {
      message2 += " ${details[i]}";
      if (i < details.length - 1) {
        message2 += ", ";
      }
    }
    print(message2);
    String message3 =
        "\n\nOur HotLine Number: 0196-99-444-00\n Show More\n $detailsLink";

    setState(() {});

    await Share.share(message + message2 + message3);
    unicTitle.clear();
    details.clear();

    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  bool enterDetailsMethodeWithLotsOfDetails = false;
  Future newGetDetails(int id) async {
    print("get details methode");
    prefss = await SharedPreferences.getInstance();

    shareInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Response? response;
    if (prefss.getString('token') == null) {
      response = await get(
        Uri.parse(
            "https://pilotbazar.com/api/clients/vehicles/products/$id/detail"),
      );
    } else {
      response = await get(
          Uri.parse(
              "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });
    }
    print("Get Details methodes");
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response!.body);
    List<dynamic> vehicleFeatures =
        decodedResponse['payload']['vehicle_feature'];

    List<FeatureDetailPair> featureDetailPairs =
        extractFeatureDetails(vehicleFeatures);
    if (featureDetailPairs.isNotEmpty) {
      enterDetailsMethodeWithLotsOfDetails = true;
      setState(() {});
    }

    for (var pair in featureDetailPairs) {
      unicTitle.add(pair.featureTitle);
      details.add(pair.detailTitles.join(', '));
    }
    shareInProgress = false;
    if (mounted) {
      setState(() {});
    }
    print("details length is");
    print(details.length);
    print("End get details methode");
  }

  bool emailInPRogress = false;

  bool emailInProgress = false;

  Future<void> shareViaEmail(int id, String vehicleName, manufacture, condition,
      registration, mileage, price, detailsLink,
      {bool isMedia = false}) async {
    print("Shared via email methode ${imageInProgress}");
    prefss = await SharedPreferences.getInstance();
    showImageList.clear();
    emailInProgress = true;
    setState(() {});
    print('Start of emailInPRogress ${emailInProgress}');

    Response? response1;

    try {
      if (prefss.getString('token') == null) {
        response1 = await get(
          Uri.parse(
              "https://pilotbazar.com/api/clients/vehicles/products/$id/detail"),
        );
      } else {
        response1 = await get(
            Uri.parse(
                "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"),
            headers: {
              'Accept': 'application/vnd.api+json',
              'Content-Type': 'application/vnd.api+json',
              'Authorization': 'Bearer ${prefss.getString('token')}'
            });
      }
      print(response1.statusCode);
      final Map<String, dynamic> decodedResponse1 = jsonDecode(response1!.body);
      print("Shared via email methode ${imageInProgress}");

      for (int b = 0; b < decodedResponse1['payload']['gallery'].length; b++) {
        ImageLink = decodedResponse1['payload']["gallery"][b]?['name'] ?? '';
        ImageLinkList.add(ImageLink);
      }

      print("From List Image Links are");
      for (int c = 0; c < ImageLinkList.length; c++) {
        print(ImageLinkList[c]);
      }

      //List<XFile> showImageList = [];
      for (int y = 0; y < ImageLinkList.length; y++) {
        print('loop of image in prpgress emailInPRogress ${emailInProgress}');
        final uri = Uri.parse(
            "https://pilotbazar.com/storage/galleries/${ImageLinkList[y]}");
        final response = await http.get(uri);
        final imageBytes = response.bodyBytes;
        final tempDirectory = await getTemporaryDirectory();
        // print("Single Image get");
        // print(" ${imageInProgress}");
        final tempFile = await File('${tempDirectory.path}/sharedImage$y.jpg')
            .writeAsBytes(imageBytes);

        final image = XFile(tempFile.path);
        showImageList.add(image);
      }

      print("Length is Unic details");
      print(details.length);
      // final Map<String, dynamic> decodedResponseForFeatures =
      //     jsonDecode(response1.body);
      // List<dynamic> vehicleFeatures =
      //     decodedResponseForFeatures['payload']['vehicle_feature'];

      // List<FeatureDetailPair> featureDetailPairs =
      //     extractFeatureDetails(vehicleFeatures);

      // for (var pair in featureDetailPairs) {
      //   unicTitle.add(pair.featureTitle);
      //   details.add(pair.detailTitles.join(', '));
      // }

      print("details length is");
      print(details.length);
      print("End get details methode");
      String message =
          "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage,${isMedia ? '' : 'price:$price'} ";
      print("length of unit title");
      print(unicTitle.length);
      String message2 = '';
      for (int i = 0; i < details.length; i++) {
        message2 += " ${details[i]}";
        if (i < details.length - 1) {
          message2 += ", "; // Add a comma and space if it's not the last index
        }
      }
      print(message2);
      setState(() {});
      print(message2);
      String message3 =
          "\n\nOur HotLine Number: 0196-99-444-00\n Show More\n $detailsLink";
      if (isMedia == true) {
        message3 = '';
        imageInProgress = false;
        setState(() {});
      }

      if (showImageList.isNotEmpty) {
        // Share all images with text
        await Share.shareXFiles(
            showImageList.map((image) => image as XFile).toList(),
            text: enterDetailsMethodeWithLotsOfDetails
                ? message + message2 + message3
                : message + message3);

        // Clear lists and reset state
        unicTitle.clear();
        details.clear();
        ImageLinkList.clear();
        showImageList.clear();
        enterDetailsMethodeWithLotsOfDetails = false;
        if (mounted) {
          setState(() {});
        }
        print("bool Whare via email loop ${imageInProgress}");
      } else {
        print("No images to share.");
      }
    } catch (error) {
      print("Error: $error");
    }
    emailInProgress = false;
    if (mounted) {
      setState(() {});
    }
    print('End of emailInPRogress ${emailInProgress}');
  }

  Future<void> shareOnlyDetailsForMedia(
    int id,
    String vehicleName,
    manufacture,
    condition,
    registration,
    mileage,
  ) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }

    String message =
        "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage ";
    print(unicTitle.length);
    String message2 = '';
    for (int i = 0; i < details.length; i++) {
      message2 += " ${details[i]}";
      if (i < details.length - 1) {
        message2 += ", "; // Add a comma and space if it's not the last index
      }
    }
    print(message2);

    setState(() {});
    await Share.share(message + message2);

    imageInProgress = false;
    unicTitle.clear();
    details.clear();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> shareOnlyDetailsWithLink(int id, String vehicleName, manufacture,
      condition, registration, mileage, price) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }

    String message =
        "$vehicleName,Manufacture: $manufacture, $condition, Registration:$registration,Mileage: $mileage Price : $price ";
    print("length of unit title");
    print(unicTitle.length);
    String message2 = '';
    for (int i = 0; i < details.length; i++) {
      message2 += " ${details[i]}";
      if (i < details.length - 1) {
        message2 += ", "; // Add a comma and space if it's not the last index
      }
    }
    print(message2);
    String message3 = "\nShow More\n $detailsLink";

    setState(() {});
    await Share.share(message + message2 + message3);
    unicTitle.clear();
    details.clear();

    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  List searchProducts = [];
  bool _searchInProgress = false;
  TextEditingController searchController = TextEditingController();
  // Search
  Future<void> search(String value) async {
    searchProducts.clear();
    products.clear();
    if (searchController.text.isEmpty) {
      getProduct(page);
    }
    _searchInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response? response;

    if (prefss.getString('token') == null) {
      response = await get(Uri.parse(
          'https://pilotbazar.com/api/clients/vehicles/products/search?search=$value'));
    } else {
      response = await get(
        Uri.parse(
            'https://pilotbazar.com/api/merchants/vehicles/products/search?search=$value'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        },
      );
    }
    final Map<String, dynamic> decodedResponse1 = jsonDecode(response.body);
    final Map<String, dynamic> decodedResponse = decodedResponse1['payload'];
    final getproductsList = decodedResponse['data'];
    int i = 0;

    for (i; i < decodedResponse['data'].length; i++) {
      products.add(Product(
        vehicleName: decodedResponse['data'][i]['translate'][0]['title'],
        vehicleNameBangla: decodedResponse['data'][i]['translate'][1]['title'],
        manufacture: decodedResponse['data'][i]['manufacture'],
        slug: decodedResponse['data'][i]['slug'],
        id: decodedResponse['data'][i]['id'],
        condition: decodedResponse['data'][i]['condition']['translate'][0]
            ['title'],
        mileage: decodedResponse['data'][i]['mileage']?['translate'][0]
                ?['title'] ??
            '--',
        //price here
        price: decodedResponse['data'][i]['price'].toString() ?? '',
        purchase_price:
            decodedResponse['data'][i]?['purchase_price'].toString() ?? '',
        fixed_price:
            decodedResponse['data'][i]?['fixed_price'].toString() ?? '',
        //price end
        imageName: decodedResponse['data'][i]['image']['name'],
        registration: decodedResponse['data'][i]['registration'] ?? 'None',
        engine: decodedResponse['data'][i]['engine']?['translate'][0]['title']
                .toString() ??
            decodedResponse['data'][i]['engines'],
        brandName: decodedResponse['data'][i]['brand']['translate'][0]['title'],
        transmission: decodedResponse['data'][i]['transmission']['translate'][0]
            ['title'],
        fuel: decodedResponse['data'][i]['fuel']['translate'][0]['title'],
        skeleton: decodedResponse['data'][i]['skeleton']['translate'][0]
            ['title'],
        available: decodedResponse['data'][i]?['available']?['translate'][0]
                ?['title'] ??
            '',
        code: decodedResponse['data'][i]?['code'].toString() ?? '',
        //model: decodedResponse['data'],
        carColor: decodedResponse['data'][i]['color']?['translate'][0]
                ['title'] ??
            'None',
        edition: decodedResponse['data'][i]['edition']['translate'][0]
                ['title'] ??
            'None',
        model: decodedResponse['data'][i]?['carmodel']?['translate'][0]
                ?['title'] ??
            '',

        grade: decodedResponse['data'][i]?['grade']?['translate'][0]
                ?['title'] ??
            '',
        engineNumber:
            decodedResponse['data'][i]['engine_number'].toString() ?? '--',
        chassisNumber:
            decodedResponse['data'][i]['chassis_number'].toString() ?? '--',
        video: decodedResponse['data'][i]?['video'] ?? 'No Video',
        engine_id: decodedResponse['data'][i]?['engine_id'].toString() ?? '12',
        onlyMileage: decodedResponse['data'][i]['mileages'].toString() ?? '--',
        engines: decodedResponse['data'][i]?['engines'].toString() ?? '-',
      ));
    }
    products.addAll(searchProducts);
    searchProducts.clear();
    _searchInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (decodedResponse['data'] == null) {
      return;
    }
  }

  bool _availabilityInProgress = false;
  List availableResponseList = [];
  Future getAvailability() async {
    prefss = await SharedPreferences.getInstance();
    _availabilityInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response availableResponse = await get(
        Uri.parse(
            'https://pilotbazar.com/api/merchants/vehicles/products/availables'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        });
    Map<String, dynamic> decodedAvilableResponse =
        jsonDecode(availableResponse.body);
    final result = decodedAvilableResponse['payload'] as List;
    setState(() {
      availableResponseList = result;
    });
    _availabilityInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  final ScrollController _scrollController = ScrollController();

  bool myBoolValue = true;
  bool fixedPriceChange = false;
  bool askingPriceChange = false;
  bool askingPriceInProgress = false;
  void updateAskingPriceFunction() {
    setState(() {
      myBoolValue = true; // Toggle the value
    });
  }

  void updateFixedPriceFunction() {
    setState(() {
      myBoolValue = false; // Toggle the value
    });
  }

  TextStyle popubItem = TextStyle(color: Colors.black87, fontFamily: 'Roboto');

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF313131),
      appBar: AppBar(
        backgroundColor: Color(0xFF666666),
        leading: Image.asset(
          'assets/images/pilot_logo2.png',
        ),
        title: TextField(
          controller: searchController,
          onSubmitted: (value) async {
            print("onSubmitted: $value");
            await search(value);
          },
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(
                    40) // Set default border color to white
                ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(
                    40) // Set focused border color to white
                ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white, fontSize: 15),
          cursorColor: Colors.white,
        ),
      ),
      endDrawer: EndDrawer(mounted: mounted),
      body: (_getProductinProgress || _searchInProgress)
          ? loading()
          : Stack(
              children: [
                Column(
                  children: [
                    (getIntPreef == 1)
                        ? AskingFixedAndStockList(
                            askingPriceFunction: () {
                              print("Asking Price function is called");
                              updateAskingPriceFunction();
                              askingPriceInProgress = false;
                              setState(() {});
                              print(askingPriceInProgress);
                            },
                            fixedPriceFunction: () {
                              print("Fixed Price Function is called");
                              askingPriceInProgress = true;
                              updateFixedPriceFunction();
                              setState(() {});
                              print(askingPriceInProgress);
                            },
                            stockListFunction: () {
                              print("StockList Price Function is called");
                            },
                          )
                        : SizedBox(),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          initState();
                          setState(() {});
                        },
                        child: ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, index) {
                            return productList(index + j, size);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              height: 4,
                              color: Color(0xFF313131),
                            );
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _getNewProductinProgress,
                      child: Align(
                          alignment: Alignment.bottomCenter, child: loading()),
                    )
                  ],
                ),
              ],
            ),
    );
  }

  Center loading() {
    return Center(
      child: SpinKitFadingCircle(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }

  productList(int x, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Card(
        elevation: 50,
        color: Color(0xFF313131),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () async {
                    print(x);
                    print("This is my on tap functioin for details");
                    print("Image name");
                    print(products[x].imageName);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VehicleDetails(
                          // ImageLinkListForVehicleDetails: [ImageLinkList],
                          id: products[x].id,
                          detailsVehicleImageName:
                              "https://pilotbazar.com/storage/vehicles/${products[x].imageName}",
                          price: products[x].price,
                          brandName: products[x].brandName,
                          vehicleName: products[x].vehicleName,
                          engine: products[x].engine,
                          detailsCondition: products[x].condition,
                          detailsMillege: products[x].mileage,
                          detailsTransmission: products[x].transmission,
                          detailsFuel: products[x].fuel,
                          skeleton: products[x].skeleton,
                          registration: products[x].registration,
                          detailsVehicleManuConditioin:
                              products[x].manufacture.toString(),
                          detailsVehicleManufacture:
                              products[x].manufacture.toString(),
                          code: products[x].code,
                          model: products[x].model,
                          color: products[x].carColor,
                          term_and_edition: products[x].edition,
                          detailsGrade: products[x].grade,
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                      "https://pilotbazar.com/storage/vehicles/${products[x].imageName}"
                      // width: 90,
                      // height: 100,
                      // fit: BoxFit.fill,
                      ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[x].vehicleName.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                              // Increased from 2
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    "R",
                                    style: TextStyle(
                                        fontSize: 10.5,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),

                                Text(
                                  products[x].registration,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  " | ",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),

                                //Text(products[x].id.toString()),
                                Text(
                                  products[x].condition.toString(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  " | ",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  products[x].onlyMileage.toString(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  ' km',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ((getIntPreef >=0))
                    //     ?
                    shareInProgress
                        ? CircularProgressIndicator()
                        : PopupMenuButton(
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 28,
                            ),
                            onSelected: (value) async {
                              if (value == 'image') {
                                await sendAllImages(products[x + j].id);
                              } else if (value == 'details') {
                                await newGetDetails(products[x + j].id);
                                await getLink(products[x + j].id);
                                await shareDetailsWithOneImage(
                                    products[x + j].id,
                                    products[x + j].imageName,
                                    products[x + j].vehicleName,
                                    products[x + j].manufacture,
                                    products[x + j].condition,
                                    products[x + j].registration,
                                    products[x + j].mileage,
                                    products[x + j].price,
                                    detailsLink);
                              } else if (value == 'detailsWithLink') {
                                await newGetDetails(products[x + j].id ?? 12);
                                await getLink(products[x + j].id ?? 12);
                                await shareOnlyDetailsWithLink(
                                  products[x + j].id,
                                  products[x + j].vehicleName,
                                  products[x + j].manufacture,
                                  products[x + j].condition,
                                  products[x + j].registration,
                                  products[x + j].mileage,
                                  products[x + j].price,
                                );
                              } else if (value == 'detailsMedia') {
                                await newGetDetails(products[x + j].id ?? 12);
                                await getLink(products[x + j].id ?? 12);
                                await shareOnlyDetailsForMedia(
                                    products[x + j].id,
                                    products[x + j].vehicleName,
                                    products[x + j].manufacture,
                                    products[x + j].condition,
                                    products[x + j].registration,
                                    products[x + j].mileage);
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: Text("Share One Image"),
                                  value: 'details',
                                  textStyle: popubItem,
                                ),
                                PopupMenuItem(
                                  child: Text("Share All Image"),
                                  value: 'image',
                                  textStyle: popubItem,
                                ),
                                PopupMenuItem(
                                  child: Text("Share Details With Link"),
                                  value: 'detailsWithLink',
                                  textStyle: popubItem,
                                ),
                                PopupMenuItem(
                                  child: Text("Share Details In Media"),
                                  value: 'detailsMedia',
                                  textStyle: popubItem,
                                ),
                              ];
                            },
                          ),
                    // : SizedBox(),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 11),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[x].available,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Row(
                            children: [
                              Text(
                                "Tk .",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(width: 5),
                              Text(
                                products[x].price.toString(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),

                              //  SizedBox(width: 100,),
                            ],
                          ),
                          Text(''),
                        ],
                      ),
                    ),
                    Spacer(),
                    (getIntPreef >= 0)
                        ? PopupMenuButton(
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 35,
                            ),
                            onSelected: (value) async {
                              if (value == 'Delete') {
                                deleteMethode(x);
                              }
                              if (value == 'Edit Price') {
                                navigateToPriceEditPage(x);
                              } else if (value == 'Booked') {
                                updateBooked(x);
                              } else if (value == 'Sold') {
                                await updateSold(x);
                              } else if (value == 'Availability') {
                                await getAvailability();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: const Color.fromARGB(
                                            255, 61, 59, 59),
                                        title: Center(
                                            child: Text(
                                          "Availability",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        )),
                                        content: Container(
                                          height: double.infinity,
                                          width: 350,
                                          child: ListView.builder(
                                            primary: false,
                                            shrinkWrap: true,
                                            itemCount:
                                                availableResponseList.length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  availableResponseList[index]
                                                      as Map;
                                              return Expanded(
                                                child: Expanded(
                                                  child: Expanded(
                                                      child: ElevatedButton(
                                                          onPressed: () async {
                                                            print(
                                                                "this is car id");
                                                            print(
                                                                products[index]
                                                                    .id);
                                                            updateAvailable(
                                                                item['id'], x);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          97,
                                                                          93,
                                                                          90)),
                                                          child: Text(
                                                              item['translate']
                                                                          [0]
                                                                      ['title']
                                                                  .toString(),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall))),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        actions: <Widget>[
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.close),
                                            color:
                                                Colors.white, // Set icon color
                                          ),
                                        ],
                                        contentPadding: EdgeInsets.only(
                                            top: 8,
                                            right: 8,
                                            bottom: 0,
                                            left: 8),
                                      );
                                    });
                              } else if (value == 'Advance') {
                                // this is for solving problem
                                // await Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ModelShowingData(

                                //             )));

                                // this is for text fild selected box
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TextFildSelectBox(
                                      id: products[x].id,
                                      availableDD: products[x].available,
                                      vehiclaName: products[x].vehicleName,
                                      vehiclaNameBangla:
                                          products[x].vehicleNameBangla,
                                      conditionValue: products[x].condition,
                                      brandName: products[x].brandName,
                                      fuel: products[x].fuel,
                                      skeleton: products[x].skeleton,
                                      transmission: products[x].transmission,
                                      registration: products[x].registration,
                                      carColor: products[x].carColor,
                                      edition: products[x].edition,
                                      model: products[x].model,
                                      grade: products[x].grade,
                                      mileage: products[x].mileage.toString(),
                                      engine: products[x].engine.toString(),
                                      purchase_price:
                                          products[x].purchase_price,
                                      price: products[x].price,
                                      fixed_price: products[x].fixed_price,
                                      engine_number: products[x].engineNumber,
                                      chassis_number: products[x].chassisNumber,
                                      code: products[x].code,
                                      video: products[x].video.toString(),
                                      manufacture: products[x].manufacture,
                                      engineId: products[x].engine_id,
                                      onlyMileage: products[x].onlyMileage,
                                      engines: products[x].engines,
                                    ),
                                  ),
                                );
                              } else if (value == 'Delete') {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              5), // Remove rounded corners
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 61, 59, 59),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 50, vertical: 20),
                                        title: Center(
                                            child: Text(
                                          "Do you want to delete?",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Axiforma'),
                                        )),
                                        // titlePadding: EdgeInsets.only(top: 20),
                                        content: Row(
                                          children: [
                                            SizedBox(height: 10),
                                            Spacer(),
                                            TextButton(
                                              onPressed: () async {
                                                await deleteMethode(
                                                    products[x + j].id ?? 0);
                                                initState();
                                              },
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Axiforma'),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'No',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Axiforma'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                //  PopupMenuItem(
                                //   child: Text("Delete"),
                                //   value: 'Delete',
                                // ),
                                PopupMenuItem(
                                  child: Text("Edit Price"),
                                  value: 'Edit Price',
                                  textStyle: popubItem,
                                ),
                                PopupMenuItem(
                                  child: Text("Booked"),
                                  value: 'Booked',
                                  textStyle: popubItem,
                                ),
                                PopupMenuItem(
                                  child: Text("Sold"),
                                  value: 'Sold',
                                  textStyle: popubItem,
                                ),

                                PopupMenuItem(
                                  child: Text("Availability"),
                                  value: 'Availability',
                                  textStyle: popubItem,
                                ),
                                PopupMenuItem(
                                  child: Text("Advance"),
                                  value: 'Advance',
                                  textStyle: popubItem,
                                ),
                                PopupMenuItem(
                                  child: Text("Delete"),
                                  value: 'Delete',
                                  textStyle: popubItem,
                                ),
                              ];
                            },
                          )
                        : SizedBox(),
                    SizedBox(width: 20),
                  ],
                ),
              ],
            ),
            ((getIntPreef <= 0))
                ? SizedBox(
                    height: size.height / 40,
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  static int j = x;

  // Update Booked
  void updateBooked(int index) async {
    prefss = await SharedPreferences.getInstance();
    final body = {
      "available_id": 20,
    };

    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/${products[index].id}/update/booked";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    print(response.statusCode);
    print(products[index].id);

    if (response.statusCode == 200) {
      print("Succesfully Booked");
    }
  }

  // delete
  deleteMethode(int id) async {
    prefss = await SharedPreferences.getInstance();
    //  final body = {
    //   "delete_id": 1,
    // };
    print(id);
    final url = "https://pilotbazar.com/api/merchants/vehicles/products/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri, headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    print(response.statusCode);

    if (response.statusCode == 200) {
      print("Succesfully Booked");
      Navigator.pop(context);
    }
  }

  // Update Sold
  updateSold(int index) async {
    prefss = await SharedPreferences.getInstance();
    final body = {
      "available_id": 22,
    };
    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/${products[index].id}/update/sold";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    print(response.statusCode);
    print(products[index].id);

    if (response.statusCode == 200) {
      print("Succesfully Sold");
    }
  }

  void updateAvailable(int availableID, int index) async {
    prefss = await SharedPreferences.getInstance();
    final body = {
      "available_id": availableID,
    };
    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/${products[index].id}/available";
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization': 'Bearer ${prefss.getString('token')}'
      },
    );
    print(response.statusCode);
    print(products[index].id);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print("Succesfully Update");
    }
  }

  navigateToEditPage(int index) {
    final route = MaterialPageRoute(
        builder: (context) => AdvanceScreen(
              id: products[index].id,
              name: products[index].vehicleName.toString(),
              price: products[index].price.toString(),
              manufacture: products[index].manufacture,
              condition: products[index].condition,
              registration: products[index].registration,
              mileage: products[index].mileage,
            ));
    Navigator.push(context, route);
  }

  navigateToPriceEditPage(int index) {
    final route = MaterialPageRoute(
        builder: (context) => PriceEditScreen(
              id: products[index].id,
              name: products[index].vehicleName.toString(),
              price: products[index].price.toString(),
              purchase_price: products[index].purchase_price,
              fixed_price: products[index].fixed_price,
            ));
    Navigator.push(context, route);
  }
}

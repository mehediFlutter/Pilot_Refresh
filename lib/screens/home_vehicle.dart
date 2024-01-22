import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/admin/asking_fixed_stockList.dart';
import 'package:pilot_refresh/problem/model_problem.dart';
import 'package:pilot_refresh/problem/model_text.dart';
import 'package:pilot_refresh/product.dart';
import 'package:pilot_refresh/screens/advance_edit_screen.dart';
import 'package:pilot_refresh/screens/auth/searchBar.dart';
import 'package:pilot_refresh/screens/edit_price.dart';
import 'package:pilot_refresh/advance/text_fild_select_box.dart';
import 'package:pilot_refresh/screens/vehicle-details.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';
import 'package:pilot_refresh/widget/alart_dialog_class.dart';
import 'package:pilot_refresh/widget/bottom_nav_base-screen.dart';
import 'package:pilot_refresh/widget/end_drawer.dart';
import 'package:pilot_refresh/widget/image_class.dart';
import 'package:pilot_refresh/widget/search_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HomeVehicle extends StatefulWidget {
  const HomeVehicle({super.key});

  @override
  State<HomeVehicle> createState() => _HomeVehicleState();
}

class _HomeVehicleState extends State<HomeVehicle> {
  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
  //static String imagePath = "https://pilotbazar.com/storage/vehicles/";
  static late int page;
  static late int i;
  //static List allSearchProducts = [];
  static List newSearchProducts = [];
  String searchValue = '';
  bool searchInProgress = false;

  @override
  initState() {
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

    // getProductForSearch();
    //getDetails(products[0].id);

    //getDetails(i);
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
    _getNewProductinProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response response =
        await get(Uri.parse("https://pilotbazar.com/api/vehicle?page=$page"));
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      decodedResponse['data'].forEach((e) {
        products.add(Product(
          vehicleName: e['translate'][0]['title'],
          vehicleNameBangla: e['translate'][1]['title'],
          id: e['id'],
          slug: e['slug'] ?? '',
          manufacture: e['manufacture'] ?? '',
          condition: e['condition']['translate'][0]?['title'] ?? '',
          mileage: e['mileage']?['translate'][0]?['title'] ?? '--',
          price: e['price'] ?? '',
          purchase_price: e['purchase_price'] ?? '',
          fixed_price: e['fixed_price'] ?? '',
          imageName: e['image']?['name'] ?? '',
          registration: e['registration'] ?? 'None',
          engine: e['engine']?['translate'][0]?['title'] ?? '',
          brandName: e['brand']?['translate'][0]?['title'] ?? '',
          transmission: e['transmission']?['translate'][0]?['title'] ?? '',
          fuel: e['fuel']?['translate'][0]?['title'] ?? '',
          skeleton: e['skeleton']?['translate'][0]?['title'] ?? '',
          available: e['available']?['translate'][0]?['title'] ?? '',
          code: e['code'] ?? '',
          carColor: e['color']['translate'][0]['title'] ?? 'None',
          edition: e['edition']['translate'][0]['title'] ?? 'None',
          model: e['carmodel']?['translate'][0]?['title'] ?? '',
          grade: e['grade']?['translate'][0]?['title'] ?? '',
           engineNumber: e['engine_number']??'--',
            chassisNumber: e['chassis_number']??'--',
            video: e['video']??'No Video',
            engine_id: e['engine_id']??'--',
            onlyMileage: e['mileages']??'--',
            engines: e['engines']??'-',
           
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
    products.clear();
    _getProductinProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response response =
        await get(Uri.parse("https://pilotbazar.com/api/vehicle?page=$page"));
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

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
        price: decodedResponse['data'][i]['price'] ?? '',
        purchase_price: decodedResponse['data'][i]?['purchase_price'] ?? '',
        fixed_price: decodedResponse['data'][i]?['fixed_price'] ?? '',
        //price end
        imageName: decodedResponse['data'][i]['image']['name'],
        registration: decodedResponse['data'][i]['registration'] ?? 'None',
        engine: decodedResponse['data'][i]['engine']['translate'][0]['title'],
        brandName: decodedResponse['data'][i]['brand']['translate'][0]['title'],
        transmission: decodedResponse['data'][i]['transmission']['translate'][0]
            ['title'],
        fuel: decodedResponse['data'][i]['fuel']['translate'][0]['title'],
        skeleton: decodedResponse['data'][i]['skeleton']['translate'][0]
            ['title'],
        available: decodedResponse['data'][i]?['available']?['translate'][0]
                ?['title'] ??
            '',
        code: decodedResponse['data'][i]?['code'] ?? '',
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
            engineNumber: decodedResponse['data'][i]['engine_number']??'--',
            chassisNumber: decodedResponse['data'][i]['chassis_number']??'--',
            video: decodedResponse['data'][i]?['video']??'No Video',
            engine_id: decodedResponse['data'][i]?['engine_id']??'12',
            onlyMileage: decodedResponse['data'][i]['mileages']??'--',
            engines: decodedResponse['data'][i]?['engines']??'-',
            
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

  Future getDetails(int id) async {
    _getDataInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response response = await get(Uri.parse(
        "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"));
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
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

    // get image link in list

    _getDataInProgress = false;
    if (mounted) {
      setState(() {});
    }

    //return unicTitle+details;
  }

  static String? detailsLink;

  Future<void> shareDetailsWithOneImage(String ImageName, vehicleName,
      manufacture, condition, registration, mileage, price, detailsLink) async {
    if (mounted) {
      setState(() {});
    }
    //setState() {});
    final uri = Uri.parse("https://pilotbazar.com/storage/vehicles/$ImageName");
    final response = await http.get(uri);
    final imageBytes = response.bodyBytes;
    final tempDirectory = await getTemporaryDirectory();
    final tempFile =
        await File('${tempDirectory.path}/sharedImage.jpg').create();
    await tempFile.writeAsBytes(imageBytes);

    //await getDetails(widget.id);
    final image = XFile(tempFile.path);
    late String info;

    String message =
        "Vehicle Name:$vehicleName  \nManufacture:$manufacture   \nConditiion:$condition  \nRegistration:$registration  \nMillage:$mileage  \nPrice:$price \nSee more\n$detailsLink ";

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

    setState(() {});
  }

  Future getLink(String id) async {
    Response response1 = await get(Uri.parse(
        "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"));
    final Map<String, dynamic> decodedResponse1 = jsonDecode(response1.body);
    detailsLink = decodedResponse1['message'];
    setState(() {});
    print(detailsLink);
  }

  static List showImageList = [];
  late String ImageLink;
  late List ImageLinkList = [];
  bool _shareAllImageInProgress = false;

  Future<void> sendWhatsImage(int id) async {
    _shareAllImageInProgress = true;
    try {
      Response response1 = await get(Uri.parse(
          "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"));
      print(response1.statusCode);
      final Map<String, dynamic> decodedResponse1 = jsonDecode(response1.body);

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
        _detailsInProgress = false;

        setState(() {});
      } else {
        print("No images to share.");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  Future<void> shareViaEmail(int id, String ImageName, vehicleName, manufacture,
      condition, registration, mileage, price, detailsLink) async {
    try {
      Response response1 = await get(Uri.parse(
          "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"));
      print(response1.statusCode);
      final Map<String, dynamic> decodedResponse1 = jsonDecode(response1.body);

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

      String message =
          "Vehicle Name:$vehicleName  \nManufacture:$manufacture   \nConditiion:$condition  \nRegistration:$registration  \nMillage:$mileage  \nPrice:$price \nSee more\n$detailsLink ";

      if (unicTitle.length != 0) {
        info = "\n${unicTitle[0]} : ${details[0]}";
        _detailsInProgress = true;
        setState(() {});
        for (int b = 1; b < unicTitle.length; b++) {
          info += "\n${unicTitle[b]} : ${details[b]}";
        }
      }

      if (showImageList.isNotEmpty) {
        // Share all images with text
        await Share.shareXFiles(
            showImageList.map((image) => image as XFile).toList(),
            text: _detailsInProgress ? message + info : message);

        // Clear lists and reset state
        unicTitle.clear();
        details.clear();
        ImageLinkList.clear();
        showImageList.clear();
        _detailsInProgress = false;

        setState(() {});
      } else {
        print("No images to share.");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  List searchProducts = [];
  bool _searchInProgress = false;
  TextEditingController searchController = TextEditingController();

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
    Response response = await get(
      Uri.parse(
          'https://pilotbazar.com/api/merchants/vehicles/products/search?search=$value'),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json'
      },
    );
    Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    int i = 0;

    for (i; i < decodedResponse['payload'].length; i++) {
      searchProducts.add(Product(
          vehicleName:
              decodedResponse['payload'][i]?['translate'][0]?['title'] ?? '-',
          manufacture: decodedResponse['payload'][i]?['manufacture'] ?? '',
          slug: decodedResponse['payload'][i]?['slug'] ?? '',
          id: decodedResponse['payload'][i]?['id'] ?? '',
          condition: "API?",
          price: decodedResponse['payload'][i]?['price'] ?? '',
          purchase_price:
              decodedResponse['payload'][i]?['purchase_price'] ?? '',
          fixed_price: decodedResponse['payload'][i]?['fixed_price'] ?? '',
          imageName: decodedResponse['payload'][i]?['image']['name'] ?? '',
          registration: "API?",
          engine: decodedResponse['payload'][i]?['engines'] ?? '-',
          brandName: decodedResponse['payload'][i]?['brand']['slug'],
          transmission: "API?",
          fuel: "API?",
          skeleton: "API?",
          available: decodedResponse['payload'][i]?['available']['slug'] ?? '-',
          code: decodedResponse['payload'][i]?['code'] ?? '-'));
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
    _availabilityInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response availableResponse = await get(Uri.parse(
        'https://pilotbazar.com/api/merchants/vehicles/products/availables'));
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

    return Scaffold(
      backgroundColor: Color(0xFF313131),
      appBar: AppBar(
        backgroundColor: Color(0xFF666666),
        leading: Image.asset(
          'assets/images/pilot_logo2.png',
        ),
        title: TextField(
          style: TextStyle(color: Colors.white, fontSize: 15),
          controller: searchController,
          onSubmitted: (value) async {
            print("onSubmitted: $value");
            await search(value);
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(40),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            // suffixIcon: IconButton(
            //   onPressed: () async {
            //     print("Hello");
            //     await search(searchController.text.toString());
            //   },
            //   icon: Icon(Icons.send, color: Colors.white),
            // ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ),
      endDrawer: EndDrawer(mounted: mounted),
      body: (_getProductinProgress || _searchInProgress)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                AskingFixedAndStockList(
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
                ),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, index) {
                    return productList(index + j);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 4,
                      color: Color(0xFF313131),
                    );
                  },
                ),
                Visibility(
                  visible: _getNewProductinProgress,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircularProgressIndicator(),
                  ),
                )
              ],
            ),
    );
  }

  productList(int x) {
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
                child: InkWell(
                  onTap: () async {
                    //  await sendWhatsImage(products[x].id);
                    print(x);
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
                              products[x].edition,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
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
                                  products[x].mileage.toString(),
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Color.fromARGB(221, 65, 64, 64),
                      radius: 25,
                      child: Expanded(
                        child: PopupMenuButton(
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 25,
                          ),
                          onSelected: (value) async {
                            if (value == 'image') {
                              sendWhatsImage(products[x + j].id);
                            } else if (value == 'details') {
                              await getLink(products[x + j].id.toString());
                              shareDetailsWithOneImage(
                                  products[x + j].imageName,
                                  products[x + j].vehicleName,
                                  products[x + j].manufacture,
                                  products[x + j].condition,
                                  products[x + j].registration,
                                  products[x + j].mileage,
                                  products[x + j].price,
                                  detailsLink);
                            } else if (value == 'email') {
                              await getLink(products[x + j].id.toString());
                              shareViaEmail(
                                  products[x + j].id,
                                  products[x + j].imageName,
                                  products[x + j].vehicleName,
                                  products[x + j].manufacture,
                                  products[x + j].condition,
                                  products[x + j].registration,
                                  products[x + j].mileage,
                                  products[x + j].price,
                                  detailsLink);
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
                                child: Text("Send Email"),
                                value: 'email',
                                textStyle: popubItem,
                              ),
                            ];
                          },
                        ),
                      ),
                    ),
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
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(221, 73, 73, 73),
                      radius: 25,
                      child: PopupMenuButton(
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                          size: 30,
                        ),
                        onSelected: (value) async {
                          // if (value == 'Delete') {
                          // Open Delete Popup
                          // deleteById(id);
                          // }
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
                                    backgroundColor:
                                        const Color.fromARGB(255, 61, 59, 59),
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
                                        itemCount: availableResponseList.length,
                                        itemBuilder: (context, index) {
                                          final item =
                                              availableResponseList[index]
                                                  as Map;
                                          return Expanded(
                                            child: Expanded(
                                              child: Expanded(
                                                  child: ElevatedButton(
                                                      onPressed: () async {
                                                        print("this is car id");
                                                        print(
                                                            products[index].id);
                                                        updateAvailable(
                                                            item['id'], x);
                                                        Navigator.pop(context);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          97,
                                                                          93,
                                                                          90)),
                                                      child: Text(
                                                          item['translate'][0]
                                                                  ['title']
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
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
                                        color: Colors.white, // Set icon color
                                      ),
                                    ],
                                    contentPadding: EdgeInsets.only(
                                        top: 8, right: 8, bottom: 0, left: 8),
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
                                  purchase_price: products[x].purchase_price,
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static int j = x;

  // Update Booked
  void updateBooked(int index) async {
    final body = {
      "available_id": 20,
    };

    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/${products[index].id}/update/booked";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/vnd.api+json',
      'Accept': 'application/vnd.api+json'
    });
    print(response.statusCode);
    print(products[index].id);

    if (response.statusCode == 200) {
      print("Succesfully Booked");
    }
  }

  // Update Sold
  updateSold(int index) async {
    final body = {
      "available_id": 22,
    };
    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/${products[index].id}/update/sold";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/vnd.api+json',
      'Accept': 'application/vnd.api+json'
    });
    print(response.statusCode);
    print(products[index].id);

    if (response.statusCode == 200) {
      print("Succesfully Sold");
    }
  }

  void updateAvailable(int availableID, int index) async {
    final body = {
      "available_id": availableID,
    };
    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/${products[index].id}/available";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Content-Type': 'application/vnd.api+json',
      'Accept': 'application/vnd.api+json'
    });
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

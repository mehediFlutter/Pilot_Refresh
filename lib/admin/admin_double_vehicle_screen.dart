import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/admin/asking_fixed_stockList.dart';
import 'package:pilot_refresh/item_class.dart';
import 'package:pilot_refresh/product.dart';
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:pilot_refresh/screens/auth/new_login_screen.dart';
import 'package:pilot_refresh/screens/auth/searchBar.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';
import 'package:pilot_refresh/widget/end_drawer.dart';
import 'package:http/http.dart' as http;

class AdminDoublVehicle extends StatefulWidget {
  final String? token;
  AdminDoublVehicle({
    super.key,
    this.token,
  });

  @override
  State<AdminDoublVehicle> createState() => _DoublVehicleState();
}

class _DoublVehicleState extends State<AdminDoublVehicle> {
  @override
  static String imagePath = "https://pilotbazar.com/storage/vehicles/";
  static late int page;
  static late int i;
  bool fixedPriceChange = false;
  bool askingPriceChange = false;
  bool askingPriceInProgress = false;

  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
  @override
  void initState() {
    print("I am on Double vehicle screen");
    print(widget.token);
    page = 1;
    i = 0;
    getProduct(page);
    _scrollController.addListener(_listenToScroolMoments);

    searchController.addListener(() {
      // Clear the searchProducts list when the text field is empty
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

  List products = [];
  List featureUnicTitle = [];
  List featureDetails = [];

  bool _getProductinProgress = false;
  bool _getNewProductinProgress = false;
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

    Response response = await get(
        Uri.parse(
            "https://pilotbazar.com/api/merchants/vehicles/products?page=$page"),
        headers: {'Retry-After': '3600', 'Content-Type': 'text/html'});
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    List<dynamic> vehicleFeatures =
        decodedResponse['data'][0]?['vehicle_feature'] ?? '';
    List<FeatureDetailPair> featureDetailPairs =
        extractFeatureDetails(vehicleFeatures);

    for (var pair in featureDetailPairs) {
      // print('Feature: ${pair.featureTitle}');
      // print('Details: ${pair.detailTitles.join(', ')}');
      featureDetails.add({pair.detailTitles.join(', ')});
      featureUnicTitle.add({pair.featureTitle});
    }

    if (response.statusCode == 200) {
      decodedResponse['data'].forEach((e) {
        //  List<Product> products = [];
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
          engineNumber: e['engine_number'] ?? '--',
          chassisNumber: e['chassis_number'] ?? '--',
          video: e['video'] ?? 'No Video',
          engine_id: e['engine_id'] ?? '--',
          onlyMileage: e['mileages'] ?? '--',
          engines: e['engines'] ?? '-',
        ));
      });

      x = j + 1;
    }
    _getNewProductinProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  // Alart dialog function/methode

  bool isLoading = false;
  @override
  void getProduct(int page) async {
    products.clear();
    _getProductinProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response response = await get(
      Uri.parse(
          "https://pilotbazar.com/api/merchants/vehicles/products?page=1"),
      headers: {
        'Accept': 'application/vnd.api+json',
        'Content-Type': 'application/vnd.api+json',
        'Authorization': 'Bearer ${widget.token}'
      },
    );
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response.statusCode);
    print(response.body);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    List<dynamic> vehicleFeatures =
        decodedResponse['payload']['data'][0]['vehicle_feature'];
    List<FeatureDetailPair> featureDetailPairs =
        extractFeatureDetails(vehicleFeatures);

    for (var pair in featureDetailPairs) {
      // print('Feature: ${pair.featureTitle}');
      // print('Details: ${pair.detailTitles.join(', ')}');
      featureDetails.add({pair.detailTitles.join(', ')});
      featureUnicTitle.add({pair.featureTitle});
    }
    if (mounted) {
      setState(() {});
    }

    // for (i; i < decodedResponse['payload']['data'].length; i++) {
    //   print('length of this products');
    //   print(decodedResponse['payload']['data'].length);
    //   products.add(
    //     Product(
    //       vehicleName: decodedResponse['payload']['data'][i]['translate'][0]['title'],
    //       vehicleNameBangla: decodedResponse['data'][i]['translate'][1]
    //           ['title'],
    //       manufacture: decodedResponse['data'][i]['manufacture'],
    //       slug: decodedResponse['data'][i]['slug'],
    //       id: decodedResponse['data'][i]['id'],
    //       condition: decodedResponse['data'][i]['condition']['translate'][0]
    //           ['title'],
    //       mileage: decodedResponse['data'][i]['mileage']?['translate'][0]
    //               ?['title'] ??
    //           '--',
    //       //price here
    //       price: decodedResponse['data'][i]['price'] ?? '',
    //       purchase_price: decodedResponse['data'][i]?['purchase_price'] ?? '',
    //       fixed_price: decodedResponse['data'][i]?['fixed_price'] ?? '',
    //       //price end
    //       imageName: decodedResponse['data'][i]['image']['name'],
    //       registration: decodedResponse['data'][i]['registration'] ?? 'None',
    //       engine: decodedResponse['data'][i]['engine']['translate'][0]['title'],
    //       brandName: decodedResponse['data'][i]['brand']['translate'][0]
    //           ['title'],
    //       transmission: decodedResponse['data'][i]['transmission']['translate']
    //           [0]['title'],
    //       fuel: decodedResponse['data'][i]['fuel']['translate'][0]['title'],
    //       skeleton: decodedResponse['data'][i]['skeleton']['translate'][0]
    //           ['title'],
    //       available: decodedResponse['data'][i]?['available']?['translate'][0]
    //               ?['title'] ??
    //           '',
    //       code: decodedResponse['data'][i]?['code'] ?? '',
    //       //model: decodedResponse['data'],
    //       carColor: decodedResponse['data'][i]['color']?['translate'][0]
    //               ['title'] ??
    //           'None',
    //       edition: decodedResponse['data'][i]['edition']['translate'][0]
    //               ['title'] ??
    //           'None',
    //       model: decodedResponse['data'][i]?['carmodel']?['translate'][0]
    //               ?['title'] ??
    //           '',
    //       grade: decodedResponse['data'][i]?['grade']?['translate'][0]
    //               ?['title'] ??
    //           '',
    //       engineNumber: decodedResponse['data'][i]['engine_number'] ?? '--',
    //       chassisNumber: decodedResponse['data'][i]['chassis_number'] ?? '--',
    //       video: decodedResponse['data'][i]?['video'] ?? 'No Video',
    //       engine_id: decodedResponse['data'][i]?['engine_id'] ?? '12',
    //       onlyMileage: decodedResponse['data'][i]['mileages'] ?? '--',
    //       engines: decodedResponse['data'][i]?['engines'] ?? '-',
    //     ),
    //   );
    // }
    if (decodedResponse['data'] == null) {
      return;
    }
    _getProductinProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (decodedResponse['data'] == null) {
      return;
    }
  }

  final ScrollController _scrollController = ScrollController();

  List searchProducts = [];
  bool _searchInProgress = false;
  TextEditingController searchController = TextEditingController();
  Item myItem = Item();
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
        //  condition: decodedResponse['data'][i]['condition']['translate'][0]
        //   ['title'],
        condition: decodedResponse['payload'][i]?['condition']['translate'][0]
                ?['title'] ??
            'None',
        price: decodedResponse['payload'][i]?['price'] ?? '',
        purchase_price: decodedResponse['payload'][i]?['purchase_price'] ?? '',
        fixed_price: decodedResponse['payload'][i]?['fixed_price'] ?? '',
        imageName: decodedResponse['payload']?[i]?['image']['name'] ?? '',
        registration:
            decodedResponse['payload']?[i]?['registration'] ?? ' None',

        engine: decodedResponse['payload'][i]?['engines'] ?? '-',
        brandName: decodedResponse['payload'][i]?['brand']['slug'],
        transmission: decodedResponse['payload']?[i]?['transmission']
                ?['translate'][0]?['title'] ??
            'None',
        fuel: decodedResponse['payload']?[i]?['fuel']?['translate'][0]
                ?['title'] ??
            'None',
        skeleton: decodedResponse['payload']?[i]?['skeleton']?['translate'][0]
                ?['title'] ??
            'None',
        available: decodedResponse['payload'][i]?['available']['slug'] ?? '-',
        code: decodedResponse['payload'][i]?['code'] ?? '-',
        onlyMileage: decodedResponse['payload'][i]?['mileages'] ?? '--',
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

  // update bool value
  bool myBoolValue = true;
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

  Widget build(BuildContext context) {
    _searchInProgress
        ? null
        : _scrollController.addListener(() {
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
          ? Center(child: loading())
          : Stack(
              children: [
                Column(
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
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          initState();
                          setState(() {});
                        },
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            //childAspectRatio: 1.0,
                            mainAxisSpacing: 2.0,
                            crossAxisSpacing: 0.0,
                          ),
                          controller: _scrollController,
                          itemCount: products.length,
                          itemBuilder: (BuildContext context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Item(
                                myAskingPrice: myBoolValue,
                                id: products[index + j].id!,
                                imageName:
                                    products[index + j].imageName.toString(),
                                price: products[index + j].price.toString(),
                                purchase_price: products[index + j]
                                    .purchase_price
                                    .toString(),
                                fixed_price:
                                    products[index + j].fixed_price.toString(),
                                vehiclaName: products[index + j].vehicleName,
                                manufacture: products[index + j].manufacture,
                                condition: products[index + j].condition,
                                nMillage: products[index + j].mileage,
                                brandName: products[index + j].brandName,
                                engine: products[index + j].engine,
                                transmission: products[index + j].transmission,
                                model: products[index + j].model,
                                fuel: products[index + j].fuel,
                                skeleton: products[index + j].skeleton,
                                code: products[index + j].code,
                                registration: products[index + j].registration,
                                available: products[index + j].available,
                                detailsLink: products[index + j].detailsLink,
                                carColor: products[index + j].carColor,
                                edition: products[index + j].edition,
                                grade: products[index + j].grade,
                                onlyMileage: products[index + j].onlyMileage,
                                engines: products[index + j].engines,
                                engineNumber: products[index + j].engineNumber,
                                chassisNumber:
                                    products[index + j].chassisNumber,
                                video: products[index + j].video,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                    visible: _getNewProductinProgress,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: loading(),
                        ),
                      ],
                    )),
              ],
            ),
    );
  }

  SpinKitFadingCircle loading() {
    return SpinKitFadingCircle(
      color: const Color.fromARGB(255, 214, 192, 192),
      size: 50.0,
    );
  }

  static int j = x;
}

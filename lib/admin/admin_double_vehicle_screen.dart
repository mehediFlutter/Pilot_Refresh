import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/admin/asking_fixed_stockList.dart';
import 'package:pilot_refresh/item_class.dart';
import 'package:pilot_refresh/product.dart';
import 'package:pilot_refresh/widget/end_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AdminDoublVehicle extends StatefulWidget {
  final String? token;
  final bool? isLogedIn;
  AdminDoublVehicle({
    super.key,
    this.token,
    this.isLogedIn,
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
  late SharedPreferences prefss;
   bool _isDeviceConnected = false;
  bool _isAlertShown = false;
  late StreamSubscription<ConnectivityResult> _subscription;

  String? toki;

  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/

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
  void initState() {
    print("I am on Double vehicle screen");
    _checkConnectivity(); 
    _listenForChanges();
     initializePreffsBool();
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
  }

  // @override
  // void dispose() {
  //   _subscription.cancel();
  //   super.dispose();
  // }

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
  _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
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
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500,fontFamily: 'Axiforma'),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Please check your internet connection and",
                style: TextStyle(color: Colors.black87, fontSize: 12,fontFamily: 'Axiforma'),
              ),
              Text(
                "try again",
                style: TextStyle(color: Colors.black87, fontSize: 12,fontFamily: 'Axiforma'),
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
                  style: TextStyle(fontSize: 17,fontFamily: 'Axiforma'),
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
      print(page);

      if (mounted) {
        setState(() {});
      }
    }
  }

  getNewProduct(int page) async {
    print("I am new products methode");
    print("Page");
    print(page);
    _getNewProductinProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response? response;
    if (prefss.getString('token') == null) {
      response = await get(
        Uri.parse(
            'https://pilotbazar.com/api/clients/vehicles/products?page=$page'),
      );
    } else {
      response = await get(
        Uri.parse(
            'https://pilotbazar.com/api/merchants/vehicles/products?page=$page'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        },
      );
    }

    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response!.statusCode);
    final Map<String, dynamic> decodedResponse1 = jsonDecode(response.body);
    final Map<String, dynamic> decodedResponse = decodedResponse1['payload'];
    if (decodedResponse['data'].isEmpty) {
      _getNewProductinProgress = false;
      if (mounted) {
        setState(() {});
      }
    }

    // List<dynamic> vehicleFeatures =
    //     decodedResponse['data'][0]?['vehicle_feature'] ?? '';
    // List<FeatureDetailPair> featureDetailPairs =
    //     extractFeatureDetails(vehicleFeatures);

    // for (var pair in featureDetailPairs) {
    //   // print('Feature: ${pair.featureTitle}');
    //   // print('Details: ${pair.detailTitles.join(', ')}');
    //   featureDetails.add({pair.detailTitles.join(', ')});
    //   featureUnicTitle.add({pair.featureTitle});
    // }
    // int total_index = decodedResponse['data'].length;

    if (response.statusCode == 200) {
      decodedResponse['data'].forEach((e) {
        if (decodedResponse['data'].isEmpty) {
          _getNewProductinProgress = false;
          if (mounted) {
            setState(() {});
          }
        }

        //  List<Product> products = [];
        products.add(Product(
          vehicleName: e['translate'][0]['title'],
          vehicleNameBangla: e['translate'][1]['title'],
          id: e['id'],
          slug: e['slug'] ?? '',
          manufacture: e['manufacture'] ?? '',
          condition: e['condition']['translate'][0]?['title'] ?? '',
          mileage: e['mileage']?['translate'][0]?['title'].toString() ?? e['mileages'].toString(),
          price: e['price'].toString() ?? '',
          purchase_price: e['purchase_price'].toString() ?? '',
          fixed_price: e['fixed_price'].toString() ?? '',
          imageName: e['image']?['name'] ?? '',
          registration: e['registration'] ?? 'None',
          engine: e['engine']?['translate'][0]?['title'] ?? e['engines'].toString(),
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
    if (decodedResponse['data'].isEmpty) {
      _getNewProductinProgress = false;
      setState(() {});
    }
  }

  // Alart dialog function/methode

  bool isLoading = false;

  Future getProduct(int page) async {
    prefss = await SharedPreferences.getInstance();
    print("Here double vehicle token from share preff");
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
    print(response.body);
    print(widget.token);
    final Map<String, dynamic> decodedResponse1 = jsonDecode(response.body);
    final Map<String, dynamic> decodedResponse = decodedResponse1['payload'];
    final getproductsList = decodedResponse['data'];
    setState(() {});
    print('Length is');
    print(getproductsList.length);

    for (i; i < getproductsList.length; i++) {
      print('length of this products');
      // print(decodedResponse['data'].length);
      products.add(
        Product(
          vehicleName: getproductsList[i]['translate'][0]['title'],
          vehicleNameBangla: getproductsList[i]['translate'][1]['title'],
          manufacture: getproductsList[i]['manufacture'],
          slug: getproductsList[i]['slug'],
          id: getproductsList[i]['id'],
          condition: getproductsList[i]['condition']['translate'][0]['title'],
          mileage:
              getproductsList[i]['mileage']?['translate'][0]?['title'] ?? '--',
          //price here
          price: getproductsList[i]['price'].toString() ,
          purchase_price: getproductsList[i]?['purchase_price'].toString() ?? '',
          fixed_price: getproductsList[i]?['fixed_price'].toString() ?? '',
          //price end
          imageName: getproductsList[i]['image']['name'],
          registration: getproductsList[i]['registration'] ?? 'None',
          engine: getproductsList[i]?['engines'].toString()??'None',
          brandName: getproductsList[i]['brand']['translate'][0]['title'],
          transmission: getproductsList[i]['transmission']['translate'][0]
              ['title'],
          fuel: getproductsList[i]['fuel']['translate'][0]['title'],
          skeleton: getproductsList[i]['skeleton']['translate'][0]['title'],
          available:
              getproductsList[i]?['available']?['translate'][0]?['title'] ?? '',
          code: getproductsList[i]?['code'] ?? '',
          //model: getproductsList,
          carColor:
              getproductsList[i]['color']?['translate'][0]['title'] ?? 'None',
          edition:
              getproductsList[i]['edition']['translate'][0]['title'] ?? 'None',
          model:
              getproductsList[i]?['carmodel']?['translate'][0]?['title'] ?? '',
          grade: getproductsList[i]?['grade']?['translate'][0]?['title'] ?? '',
          engineNumber: getproductsList[i]['engine_number'] ?? '--',
          chassisNumber: getproductsList[i]['chassis_number'] ?? '--',
          video: getproductsList[i]?['video'] ?? 'No Video',
          engine_id: getproductsList[i]?['engine_id'] .toString()?? '12',
          onlyMileage: getproductsList[i]['mileages'].toString() ?? '--',
          engines: getproductsList[i]?['engines'].toString() ?? '-',
        ),
      );
      for(var item in products){
        print(item.vehicleName.toString());
      }
    }
    if (getproductsList == null) {
      return;
    }
    _getProductinProgress = false;
    if (mounted) {
      setState(() {});
    }

    if (getproductsList == null) {
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

    for (i; i < getproductsList.length; i++) {
      print('length of this products');
      // print(decodedResponse['data'].length);
      searchProducts.add(
        Product(
          vehicleName: getproductsList[i]['translate'][0]['title'],
          vehicleNameBangla: getproductsList[i]['translate'][1]['title'],
          manufacture: getproductsList[i]['manufacture'],
          slug: getproductsList[i]['slug'],
          id: getproductsList[i]['id'],
          condition: getproductsList[i]['condition']?['translate'][0]
                  ?['title'] ??
              "Condition None",
          mileage: getproductsList[i]['mileage']?['translate'][0]?['title'].toString() ??
              getproductsList[i]['mileages'].toString(),
          //price here
          price: getproductsList[i]['price'].toString() ?? '',
          purchase_price: getproductsList[i]?['purchase_price'].toString() ?? '',
          fixed_price: getproductsList[i]?['fixed_price'].toString() ?? '',
          //price end
          imageName: getproductsList[i]['image']['name'],
          registration: getproductsList[i]['registration'] ?? 'None',
          engine: getproductsList[i]?['engines'].toString() ?? '--',
          brandName: getproductsList[i]['brand']['translate'][0]['title'],
          transmission: getproductsList[i]['transmission']['translate'][0]
              ['title'],
          fuel: getproductsList[i]['fuel']['translate'][0]['title'],
          skeleton: getproductsList[i]['skeleton']['translate'][0]['title'],
          available:
              getproductsList[i]?['available']?['translate'][0]?['title'] ?? '',
          code: getproductsList[i]?['code'].toString() ?? '',
          //model: getproductsList,
          carColor:
              getproductsList[i]['color']?['translate'][0]['title'] ?? 'None',
          edition:
              getproductsList[i]['edition']['translate'][0]['title'] ?? 'None',
          model:
              getproductsList[i]?['carmodel']?['translate'][0]?['title'] ?? '',
          grade: getproductsList[i]?['grade']?['translate'][0]?['title'] ?? '',
          engineNumber: getproductsList[i]['engine_number'].toString() ?? '--',
          chassisNumber: getproductsList[i]['chassis_number'].toString() ?? '--',
          video: getproductsList[i]?['video'] ?? 'No Video',
          engine_id: getproductsList[i]?['engine_id'].toString() ?? '12',
          onlyMileage: getproductsList[i]['mileages'].toString() ?? '--',
          engines: getproductsList[i]?['engines'].toString() ?? '-',
        ),
      );
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
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: Item(
                                isLoggedIn: widget.isLogedIn,
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

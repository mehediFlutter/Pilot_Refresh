import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/item_class.dart';
import 'package:pilot_refresh/product.dart';
import 'package:pilot_refresh/screens/auth/auth_utility.dart';
import 'package:pilot_refresh/screens/auth/new_login_screen.dart';
import 'package:pilot_refresh/screens/auth/searchBar.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';
import 'package:pilot_refresh/widget/end_drawer.dart';
import 'package:pilot_refresh/widget/search_bar.dart';

class DoublVehicle extends StatefulWidget {
  DoublVehicle({super.key});

  @override
  State<DoublVehicle> createState() => _DoublVehicleState();
}

class _DoublVehicleState extends State<DoublVehicle> {
  @override
  static String imagePath = "https://pilotbazar.com/storage/vehicles/";
  static late int page;
  static late int i;

  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
  @override
  void initState() {
    //  print("Bangla name is");
    // print(products[0].vehiclaNameBangla);
    page = 1;
    i = 0;
     getProduct(page);

    super.initState();
     _scrollController.addListener(_listenToScroolMoments);


   searchController.addListener(() {  
      page = 1;
      i = 0;

      // Clear the searchProducts list when the text field is empty
      if (searchController.text.isEmpty) {
        searchProducts.clear();
        products.clear();
        getProduct(page);
        setState(() {});
      }
      _listenToScroolMoments;
    });

    setState(() {});
    
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

    Response response =
        await get(Uri.parse("https://pilotbazar.com/api/vehicle?page=$page"));
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
          vehicleName: e['translate'][0]?['title'] ?? "",
           vehicleNameBangla:e['translate'][0]['title'],
          id: e['id'] ?? "",
          slug: e['slug'] ?? '',
          manufacture: e['manufacture'] ?? '',
          condition: e['condition']['translate'][0]?['title'] ?? '',
          mileage: e['mileage']?['translate'][0]?['title'] ?? 'No mileage data',
          price: e['price'] ?? '',
          purchase_price: e['purchase_price'] ?? '',
          fixed_price: e['fixed_price'] ?? '',
          imageName: e['image']?['name'] ?? '',
          //registration: e['registration'] ?? '',
          registration: e['registration'] ?? '',
          engine: e['engine']?['translate'][0]?['title'] ?? '',
          brandName: e['brand']?['translate'][0]?['title'] ?? '',
          transmission: e['transmission']?['translate'][0]?['title'] ?? '',
          fuel: e['fuel']?['translate'][0]?['title'] ?? '',
          skeleton: e['skeleton']?['translate'][0]?['title'] ?? '',
          code: e['code'] ?? '',
          available: e['available']?['translate'][0]?['title'] ?? '-',
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
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(''),
          content: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Do you want to logout?',
              style: TextStyle(color: Colors.black87, fontSize: 15),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No'),
                  ),
                  SizedBox(width: 5),
                  TextButton(
                    onPressed: () async {
                      await AuthUtility.clearUserInfo();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewLoginScreen()),
                          (route) => false);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Successfully Logout")));
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  bool isLoading = false;
  @override
  void getProduct(int page) async {
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
    List<dynamic> vehicleFeatures =
        decodedResponse['data'][0]['vehicle_feature'];
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
     

    for (i; i < decodedResponse['data'].length; i++) {
    
      products.add(Product(
          vehicleName:
              decodedResponse['data'][i]['translate'][0]?['title'] ?? "",
               vehicleNameBangla: decodedResponse['data'][i]['translate'][0]['title'],
          manufacture: decodedResponse['data'][i]?['manufacture'] ?? '',
          slug: decodedResponse['data'][i]?['slug'] ?? '',
          id: decodedResponse['data'][i]?['id'] ?? '',
          condition: decodedResponse['data'][i]?['condition']?['translate'][0]
                  ?['title'] ??
              '',
          mileage: decodedResponse['data'][i]['mileage']?['translate'][0]
                  ?['title'] ??
              'No mileage data',
          price: decodedResponse['data'][i]?['price'] ?? '',
          purchase_price: decodedResponse['data'][i]?['purchase_price'] ?? '',
          fixed_price: decodedResponse['data'][i]?['fixed_price'] ?? '',
          imageName: decodedResponse['data'][i]?['image']?['name'] ?? '',
          // registratin
          registration: decodedResponse['data'][i]?['registration'] ?? '-',
          engine: decodedResponse['data'][i]?['engine']?['translate'][0]?['title'] ??
              '',
          brandName: decodedResponse['data'][i]?['brand']?['translate'][0]
                  ?['title'] ??
              '',
          transmission: decodedResponse['data'][i]?['transmission']
                  ?['translate'][0]?['title'] ??
              '',
          fuel: decodedResponse['data'][i]?['fuel']?['translate'][0]?['title'] ??
              '',
          skeleton:
              decodedResponse['data'][i]?['skeleton']?['translate'][0]?['title'] ?? '',
          code: decodedResponse['data'][i]?['code'] ?? '',
          available: decodedResponse['data'][i]?['available']?['translate'][0]?['title'] ?? '',
          detailsLink: decodedResponse['message']));
         
    }
    if (decodedResponse['data'] == null) {
      return;
    }
    _getProductinProgress = false;
    if (mounted) {
      setState(() {});
    }
    

    // if (decodedResponse['data'] == null) {
    //   return;
    // }

    // show title and details
//      List unitTitles = [];
//  List features = [];
//     decodedResponse['data'].forEach((e) {
//       e['vehicle_feature'].forEach((a) {
//         unitTitles.add(a['feature']['title']);

//         print(a['feature']['title']);
//         print(a['detail']['title']);
//       });
//     });
  }

  final ScrollController _scrollController = ScrollController();

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
    Map<String,dynamic> decodedResponse = jsonDecode(response.body);
    int i = 0;

    for (i; i < decodedResponse['payload'].length; i++) {
      searchProducts.add(Product(
          vehicleName:
              decodedResponse['payload'][i]?['translate'][0]?['title'] ?? '-',
              vehicleNameBangla:  decodedResponse['payload'][i]?['translate'][1]?['title'] ?? '-',
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

      products.addAll(searchProducts);
      searchProducts.clear();
    }

    _searchInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (decodedResponse['data'] == null) {
      return;
    }
  }

  Widget build(BuildContext context) {

    _searchInProgress?null: _scrollController.addListener(() {
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
              await search(value);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 25),
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(40)),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              suffixIcon: Icon(
                Icons.send,
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: BorderSide(color: Colors.white)),
            ),
          ),
        ),
        endDrawer: EndDrawer(mounted: mounted),
        // appBar: AppBar(

        //   actions: [
        //     IconButton(
        //         onPressed: () async {
        //           _showAlertDialog(context);
        //         },
        //         icon: Icon(Icons.logout))
        //   ],
        // ),
        body: (_getProductinProgress || _searchInProgress)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      //childAspectRatio: 1.0,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 0.0,
                    ),
                    controller: _scrollController,
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Item(
                          id: products[index + j].id!,
                          imageName: products[index + j].imageName.toString(),
                          price: products[index + j].price.toString(),
                          purchase_price:
                              products[index + j].purchase_price.toString(),
                          fixed_price:
                              products[index + j].fixed_price.toString(),
                          featureSeat: featureUnicTitle[index + j].toString(),
                          featureSeatDetails:
                              featureDetails[index + j].toString(),
                          vehiclaName: products[index + j].vehicleName,
                          vehiclaNameBangla: products[index + j].vehicleNameBangla,
                          manufacture: products[index + j].manufacture,
                          condition: products[index + j].condition,
                          nMillage: products[index + j].mileage,
                          brandName: products[index + j].brandName,
                          engine: products[index + j].engine,
                          transmission: products[index + j].transmission,
                          model: "",
                          fuel: products[index + j].fuel,
                          skeleton: products[index + j].skeleton,
                          code: products[index + j].code,
                          registration: products[index + j].registration,
                          available: products[index + j].available,
                          detailsLink: products[index + j].detailsLink,

                          //dropdownFontLight: products[index+j],
                        ),
                      );
                    },
                  ),
                  Visibility(
                      visible: _getNewProductinProgress,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: CircularProgressIndicator())),
                ],
              ));
  }

  static int j = x;
}

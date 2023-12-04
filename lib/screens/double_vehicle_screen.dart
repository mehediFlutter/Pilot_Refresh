import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/class_practice.dart';
import 'package:pilot_refresh/item_class.dart';
import 'package:pilot_refresh/product.dart';

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
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_listenToScroolMoments);
    page = 1;
    i = 0;
    setState(() {});

    getProduct(page);
  }

  List<SearchProduct> products = [];
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
    print("page number");
    print(page);
    print("Length of products ");
    print(products.length);

    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    // List<dynamic> vehicleFeatures =
    //     decodedResponse['data'][0]?['vehicle_feature']??'';
    //     if(decodedResponse['data'][null])return;
    // List<FeatureDetailPair> featureDetailPairs =
    //     extractFeatureDetails(vehicleFeatures);

    // for (var pair in featureDetailPairs) {
    //   // print('Feature: ${pair.featureTitle}');
    //   // print('Details: ${pair.detailTitles.join(', ')}');
    //   featureDetails.add({pair.detailTitles.join(', ')});
    //   featureUnicTitle.add({pair.featureTitle});
    // }

    if (response.statusCode == 200) {
      decodedResponse['data'].forEach(
        (e) {
          products.add(SearchProduct(
            vehicleName: e['translate'][0]?['title']??"",
            id: e['id']??'',
            slug: e['slug']??'',
            manufacture: e['manufacture']??'',
            condition: e['condition']?['translate'][0]?['title']??"",
            mileage: e['mileage']?['translate'][0]?['title'] ?? 'No mileage data',
            price: e['price']??'',
            imageName: e['image']?['name']??'',
             brandName: e['brand']?['translate'][0]?['title']??'',
             
          ));
        },
      );
      x = j + 1;

      // decodedResponse['data']['vehicle_feature'].forEach((e) {
      //   feature_title.add(e['feature']['title'].toString());
      //   print(feature_title.toString());
      // });
      // for (int a = 0; a < 20; a++) {
      //   feature_title.add(decodedResponse['data']['vehicle_feature'][1]);
      //   if (mounted) {
      //     setState(() {});
      //   }
      //   print(feature_title[a]);
      // }
    }
    //if(decodedResponse['data'][null])return;

    _getNewProductinProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool _loadDetailsInProgress = false;

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
    print("page number");
    print(page);
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

    for (i; i < decodedResponse['data'].length; i++) {
      products.add(SearchProduct(
        
        vehicleName: decodedResponse['data'][i]['translate'][0]?['title']??'',
        manufacture: decodedResponse['data'][i]['manufacture']??'',
        slug: decodedResponse['data'][i]['slug']??'',
        id: decodedResponse['data'][i]['id']??'',
        condition: decodedResponse['data'][i]['condition']?['translate'][0]?
            ['title']??'',
        mileage: decodedResponse['data'][i]['mileage']?['translate'][0]?['title'] ?? 'No mileage data',
        price: decodedResponse['data'][i]['price']??'',
        imageName: decodedResponse['data'][i]['image']?['name']??'',
        registration: decodedResponse['data'][i]['registration']??'',
        brandName: decodedResponse['data'][i]['brand']?['translate'][0]?['title']??'',
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

  final ScrollController _scrollController = ScrollController();

  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Scaffold(
            appBar: AppBar(
              title: Text(page.toString()),
            ),
            body: _getProductinProgress
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    children: [
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          //childAspectRatio: 1.0,
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 0.0,
                        ),
                        controller: _scrollController,
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Item(
                              id: products[index + j].id!,
                              imageName: products[index + j].imageName.toString(),
                              price: products[index + j].price.toString(),
                              featureSeat: featureUnicTitle[index + j].toString(),
                              featureSeatDetails:
                                  featureDetails[index + j].toString(),
                              vehiclaName: products[index + j].vehicleName,
                              manufacture: products[index + j].manufacture,
                              condition: products[index + j].condition,
                              nMillage: products[index + j].mileage,
                              brandName: products[x].brandName,
                              engine: products[x].engine,
                              transmission: products[x].transmission,
                              model: "",
                              fuel: products[x].fuel,
                              skeleton: products[x].skeleton,
                              
                            
                              //dropdownFontLight: products[index+j],
                            ),
                          );
                        },
                      ),
                      Visibility(
                      visible: _getNewProductinProgress,
                       child: Align( alignment: Alignment.bottomCenter, child: CircularProgressIndicator())),
                    ],
                  )),
      ),
    );
  }

  static int j = x;
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/item_class.dart';
import 'package:pilot_refresh/product.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';

class AllVehicle extends StatefulWidget {
  AllVehicle({super.key});

  @override
  State<AllVehicle> createState() => _AllVehicleState();
}

class _AllVehicleState extends State<AllVehicle> {
  @override
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

  List<Product> products = [];
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
        decodedResponse['data'][0]?['vehicle_feature']??'';
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
        products.add(Product(
          vehicleName: e['translate'][0]?['title']??"",
          id: e['id']??"",
          slug: e['slug']??'',
          manufacture: e['manufacture']??'',
          condition: e['condition']['translate'][0]?['title'] ?? '',
          mileage: e['mileage']?['translate'][0]?['title'] ?? 'No mileage data',
           price: e['price'] ?? '',
            purchase_price: e['purchase_price']??'',
           fixed_price: e['fixed_price']??'',
           imageName: e['image']?['name'] ?? '',
           registration: e['registration'] ?? '',
           engine: e['engine']?['translate'][0]?['title'] ?? '',
           brandName: e['brand']?['translate'][0]?['title'] ?? '',
           transmission: e['transmission']?['translate'][0]?['title'] ?? '',
           fuel: e['fuel']?['translate'][0]?['title'] ?? '',
           skeleton: e['skeleton']?['translate'][0]?['title'] ?? '',
        ));
      });

      x = j + 1;
    }
    _getNewProductinProgress = false;
    if (mounted) {
      setState(() {});
    }
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
        vehicleName: decodedResponse['data'][i]['translate'][0]?['title']??"",
        manufacture: decodedResponse['data'][i]?['manufacture']??'',
        slug: decodedResponse['data'][i]?['slug']??'',
        id: decodedResponse['data'][i]?['id']??'',
        condition: decodedResponse['data'][i]?['condition']?['translate'][0]?
            ['title']??'',
        mileage: decodedResponse['data'][i]['mileage']?['translate'][0]
                ?['title'] ??
            'No mileage data',
        price: decodedResponse['data'][i]?['price']??'',
        purchase_price: decodedResponse['data'][i]?['purchase_price']??'',
        fixed_price: decodedResponse['data'][i]?['fixed_price']??'',
        imageName: decodedResponse['data'][i]?['image']?['name']??'',
        registration: decodedResponse['data'][i]?['registration'] ?? '-',
        engine: decodedResponse['data'][i]?['engine']?['translate'][0]?['title']??'',
        brandName: decodedResponse['data'][i]?['brand']?['translate'][0]?['title']??'',
        transmission: decodedResponse['data'][i]?['transmission']?['translate'][0]?
            ['title']??'',
        fuel: decodedResponse['data'][i]?['fuel']?['translate'][0]?['title']??'',
        skeleton: decodedResponse['data'][i]?['skeleton']?['translate'][0]?
            ['title']??'',
      ));
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

  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Scaffold(
         backgroundColor: Color(0xFF313131),
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
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 0.0,
                        ),
                        controller: _scrollController,
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Item(
                              id: products[index+j].id!,
                              imageName: products[index+j].imageName.toString(),
                              price: products[index+j].price.toString(),
                              purchase_price: products[index+j].purchase_price.toString(),
                              fixed_price: products[index+j].fixed_price.toString(),
                             
                              vehiclaName: products[index+j].vehicleName,
                              manufacture: products[index+j].manufacture,
                              condition: products[index+j].condition,
                              nMillage: products[index+j].mileage,
                              brandName: products[index+j].brandName,
                              engine: products[index+j].engine,
                              transmission: products[index+j].transmission,
                              model: "",
                              fuel: products[index+j].fuel,
                              skeleton: products[index+j].skeleton,

                              
                            
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
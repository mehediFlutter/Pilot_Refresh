import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/class_practice.dart';
import 'package:pilot_refresh/product.dart';
import 'package:pilot_refresh/screens/edit_screen.dart';
import 'package:pilot_refresh/screens/vehicle-details.dart';
import 'package:pilot_refresh/screens/vehicle_details_demo_screen.dart';
import 'package:pilot_refresh/search/pilot_search.dart';
import 'package:pilot_refresh/widget/app_bar.dart';
import 'package:pilot_refresh/widget/end_drawer.dart';
import 'package:pilot_refresh/widget/search_bar.dart';
import 'package:pilot_refresh/widget/search_deligate.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HomeVehicle extends StatefulWidget {
  HomeVehicle({super.key});

  @override
  State<HomeVehicle> createState() => _HomeVehicleState();
}

class _HomeVehicleState extends State<HomeVehicle> {
  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
  static String imagePath = "https://pilotbazar.com/storage/vehicles/";
  static late int page;
  static late int i;
  static List allSearchProducts = [];
  static List newSearchProducts = [];
  String searchValue = '';
  bool searchInProgress = false;
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
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    // List<dynamic> vehicleFeatures =
    //     decodedResponse['data'][0]['vehicle_feature'];
    // List<FeatureDetailPair> featureDetailPairs =
    //     extractFeatureDetails(vehicleFeatures);

    // for (var pair in featureDetailPairs) {
    //   // print('Feature: ${pair.featureTitle}');
    //   // print('Details: ${pair.detailTitles.join(', ')}');
    //   featureDetails.add({pair.detailTitles.join(', ')});
    //   featureUnicTitle.add({pair.featureTitle});
    // }

    if (response.statusCode == 200) {
      decodedResponse['data'].forEach((e) {
        products.add(SearchProduct(
          vehicleName: e['translate'][0]['title'],
          id: e['id'],
          slug: e['slug']??'',
          manufacture: e['manufacture']??'',
          condition: e['condition']['translate'][0]?['title'] ?? '',
          mileage: e['mileage']?['translate'][0]?['title'] ?? 'No mileage data',
          // price: e['price'] ?? 0,
          // imageName: e['image']['name'] ?? '-',
          // registration: e['registration'] ?? '-',
          // engine: e['engine']['translate'][0]['title'] ?? '-',
          // brandName: e['brand']['translate'][0]['title'] ?? '-',
          // transmission: e['transmission']['translate'][0]['title'] ?? '-',
          // fuel: e['fuel']['translate'][0]['title'] ?? '-',
          // skeleton: e['skeleton']['translate'][0]['title'] ?? '-',
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
      products.add(SearchProduct(
        vehicleName: decodedResponse['data'][i]['translate'][0]['title'],
        manufacture: decodedResponse['data'][i]['manufacture'],
        slug: decodedResponse['data'][i]['slug'],
        id: decodedResponse['data'][i]['id'],
        condition: decodedResponse['data'][i]['condition']['translate'][0]
            ['title'],
        mileage: decodedResponse['data'][i]['mileage']?['translate'][0]
                ?['title'] ??
            'No mileage data',
        price: decodedResponse['data'][i]['price'],
        imageName: decodedResponse['data'][i]['image']['name'],
        registration: decodedResponse['data'][i]['registration'] ?? '-',
        engine: decodedResponse['data'][i]['engine']['translate'][0]['title'],
        brandName: decodedResponse['data'][i]['brand']['translate'][0]['title'],
        transmission: decodedResponse['data'][i]['transmission']['translate'][0]
            ['title'],
        fuel: decodedResponse['data'][i]['fuel']['translate'][0]['title'],
        skeleton: decodedResponse['data'][i]['skeleton']['translate'][0]
            ['title'],
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
    return Scaffold(
      backgroundColor: Color(0xFF313131),
      appBar: AppBar(
        backgroundColor: Color(0xFF666666),
        //leading: Icon(Icons.image,size: 100,),
        //
        //leading:Image.asset('assets/images/pilot_logo.png',width: 80,height:30,fit: BoxFit.cover,),
        title: SearchBarClass(
          onChanged: (value) {
            //updateList(value);
          },
        ),
      ),
      endDrawer: EndDrawer(mounted: mounted),
      body: _getProductinProgress
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Visibility(
              visible: products.isNotEmpty,
              replacement: Text("No Data", style: TextStyle(fontSize: 20)),
              child: Expanded(
                child: Expanded(
                  child: Stack(
                    children: [
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
                              child: CircularProgressIndicator()))
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  productList(int x) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 20,
          child: ListTile(
            tileColor: Color(0xFF313131),
            title: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  print("Index number is ");
                  print(x);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VehicleDetails(
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
                      ),
                    ),
                  );
                },
                child: searchInProgress
                    ? Column(
                        children: [
                          Text(newSearchProducts[x].id.toString()),
                          Text(newSearchProducts[x].vehicleName.toString()),
                        ],
                      )
                    : Stack(
                        children: [
                          Image.network(
                              "https://pilotbazar.com/storage/vehicles/${products[x].imageName}"
                              // width: 90,
                              // height: 100,
                              // fit: BoxFit.fill,
                              ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                    onTap: () {
                                      navigateToEditPage(x);
                                    },
                                    child: Image.asset(
                                        'assets/images/edit_icon.png'))),
                          ),
                        ],
                      ),
              ),
            ),
            //"https://pilotbazar.com/storage/vehicles/${products[x].imageName}"
            subtitle: InkWell(
              onTap: () {
                print("I am on press");
                _showAlertDialog(context);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products[x].id.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    products[x].vehicleName.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "R: ",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        products[x].manufacture.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        " | ",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      //Text(products[x].id.toString()),
                      Text(
                        products[x].condition.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        " | ",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        products[x].mileage.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Text(
                    "Available At (PBL)",
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
                      Spacer(),
                      PopupMenuButton(
                        iconColor: Colors.white,
                        iconSize: 30,
                        onSelected: (value) {
                          if (value == 'Edit') {
                            // Open Edit Popup
                            navigateToEditPage(x);
                          } else if (value == 'Delete') {
                            // Open Delete Popup
                            //deleteById(id);
                          }
                        },
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: Text("Price"),
                              value: 'Price',
                            ),
                            PopupMenuItem(
                              child: Text("Booked"),
                              value: 'Booked',
                            ),
                            PopupMenuItem(
                              child: Text("Sold"),
                              value: 'Sold',
                            ),
                            PopupMenuItem(
                              child: Text("Edit"),
                              value: 'Edit',
                            ),
                            PopupMenuItem(
                              child: Text("Availability"),
                              value: 'Availability',
                            ),
                            PopupMenuItem(
                              child: Text("Advance"),
                              value: 'Advance',
                            ),
                            PopupMenuItem(
                              child: Text("Delete"),
                              value: 'Delete',
                            ),
                          ];
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final uri = Uri.parse(
                              "https://pilotbazar.com/storage/vehicles/${products[x].imageName}");
                          final response = await http.get(uri);
                          final imageBytes = response.bodyBytes;
                          final tempDirectory = await getTemporaryDirectory();
                          final tempFile = await File(
                                  '${tempDirectory.path}/sharedImage.jpg')
                              .create();
                          await tempFile.writeAsBytes(imageBytes);

                          final image = XFile(tempFile.path);
                          await Share.shareXFiles([image],
                              text:
                                  "Vehicle Name: ${products[x].vehicleName} \nManufacture:  ${products[x].manufacture} \nConditiion: ${products[x].condition} \nRegistration: ${products[x].registration} \nMillage: ${products[x].mileage}, \nPrice: ${products[x].price} \nOur HotLine Number: 017xxxxxxxx");
                        },
                        child: Icon(
                          Icons.share,
                          size: 20,
                        ),
                        // label: Text("SHARE"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static int j = x;

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlartDialogPage();
      },
    );
  }

  navigateToEditPage(int index) {
    final route = MaterialPageRoute(
        builder: (context) => EditScreen(
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
}

class AlartDialogPage extends StatelessWidget {
  const AlartDialogPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF232323),
      contentPadding: EdgeInsets.zero,
      title: Text(
        "Fuatures and ",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Roof",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "sunroof",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "moon roof",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "moon roof",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "moon roof",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "moon roof",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "moon roof",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Seat",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "1 set",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "2 set",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "2 set",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "2 set",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "2 set",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      "2 set",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
          color: Colors.white,
        ),
        // TextButton(
        //   child: const Text('Confirm'),
        //   onPressed: () {
        //     // Handle the confirm action
        //   },
        // ),
      ],
    );
  }
}

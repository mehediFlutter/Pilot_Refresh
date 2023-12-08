import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/product.dart';
import 'package:pilot_refresh/screens/edit_price.dart';
import 'package:pilot_refresh/screens/edit_screen.dart';
import 'package:pilot_refresh/screens/home_vehicle.dart';
import 'package:pilot_refresh/screens/vehicle-details.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';
import 'package:pilot_refresh/widget/alart_dialog_class.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Item extends StatefulWidget {
  final int id;
  final String imageName;
  final String? price;
  final String? purchase_price;
  final String? fixed_price;
  final String? dropdownFontLight;
  final String? dropdownFontLightAnswer;
  final String? dropdownSeat;
  final String? dropdownSeatAnswer;
  final String? dropdownRoof;
  final String? dropdownRoofAnswer;
  final String? dropdownStarOption;
  final String? dropdownStarOptionAnswer;
  final String? featureSeat;
  final String? featureSeatDetails;
  final int? jj;
  final String? vehiclaName;
  final String? brandName;
  final String? registration;
  final String? manufacture;
  final String? condition;
  final String? nMillage;
  final String? engine;
  final String? model;
  final String? fuel;
  final String? skeleton;
  final String? transmission;
  final String? termAndCondition;
  Item({
    super.key,
    required this.id,
    required this.imageName,
    this.price,
    this.purchase_price,
    this.fixed_price,
    this.dropdownFontLight,
    this.dropdownFontLightAnswer,
    this.dropdownSeat,
    this.dropdownSeatAnswer,
    this.dropdownRoof,
    this.dropdownRoofAnswer,
    this.dropdownStarOption,
    this.dropdownStarOptionAnswer,
    this.featureSeat,
    this.featureSeatDetails,
    this.jj,
    this.vehiclaName,
    this.brandName,
    this.registration,
    this.manufacture,
    this.condition,
    this.nMillage,
    this.engine,
    this.transmission,
    this.model,
    this.fuel,
    this.skeleton,
    this.termAndCondition,
  });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
late int id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     id=widget.id??0;
  }
  bool _detailsInProgress = false;
static List unicTitle = [];
  static List details = [];
  
  bool _getDataInProgress = false;
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
    _getDataInProgress = false;
    if (mounted) {
      setState(() {});
    }
    //return unicTitle+details;
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Card(
            color: Color(0xFF313131),
            margin: EdgeInsets.only(bottom: 1, top: 0),
            elevation: 7,
            child: Padding(
              padding: EdgeInsets.only(left: 3),
              child: Stack(
                children: [
                  ListTile(
                    tileColor: Color(0xFF313131),
                    contentPadding: EdgeInsets.zero,
                    title: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VehicleDetails(
                                        id: widget.id,
                                        vehicleName: widget.vehiclaName,
                                        detailsVehicleImageName:
                                            "https://pilotbazar.com/storage/vehicles/${widget.imageName}",
                                        price: widget.price,
                                        brandName: widget.brandName,
                                        engine: widget.engine,
                                        detailsCondition: widget.condition,
                                        detailsMillege: widget.nMillage,
                                        detailsTransmission:
                                            widget.transmission,
                                        model: widget.model,
                                        detailsFuel: widget.fuel,
                                        skeleton: widget.skeleton,
                                        registration: widget.registration,
                                        detailsGrade: "",
                                      )));
                        },
                        child: Image.network(
                          "https://pilotbazar.com/storage/vehicles/${widget.imageName}",
                          width: 50,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    subtitle: InkWell(
                         onTap: () {
                      print("pressed");
                      print(widget.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlartDialogClass(
                            id: widget.id,
                            vehicleName: widget.vehiclaName,
                            brandName: widget.brandName,
                            engine: widget.engine,
                            detailsCondition: widget.condition,
                            detailsMillege: widget.nMillage,
                            detailsTransmission: widget.transmission,
                            detailsFuel: widget.fuel,
                            skeleton: widget.skeleton,
                            registration: widget.registration,
                            detailsVehicleManuConditioin:
                                widget.manufacture.toString(),
                            detailsVehicleManufacture:
                                widget.manufacture.toString(),
                          ),
                        ),
                      );
                    },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(widget.vehiclaName.toString(),
                                style: Theme.of(context).textTheme.bodyLarge),
                            
                            Row(
                              children: [
                                Text(
                                  "R:",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  widget.registration.toString(),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text("Used",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text(
                                  " | ",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),

                                //Text(products[x].id.toString()),
                                Text("m: ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text(" | ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text(widget.nMillage.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tk: ",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Text(widget.price.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                Spacer(),
                                

                                InkWell(
                                  onTap: () async {
                      if (mounted) {
                        setState(() {});
                      }
                      //setState() {});
                      final uri = Uri.parse(
                          "https://pilotbazar.com/storage/vehicles/${widget.imageName}");
                      final response = await http.get(uri);
                      final imageBytes = response.bodyBytes;
                      final tempDirectory = await getTemporaryDirectory();
                      final tempFile =
                          await File('${tempDirectory.path}/sharedImage.jpg')
                              .create();
                      await tempFile.writeAsBytes(imageBytes);

                      await getDetails(widget.id);
                      final image = XFile(tempFile.path);

                      print("Length is ");
                      print(unicTitle.length);
                      late String info;

                      String message =
                          "Vehicle Name: ${widget.vehiclaName} \nManufacture:  ${widget.manufacture} \nConditiion: ${widget.condition} \nRegistration: ${widget.registration} \nMillage: ${widget.nMillage}, \nPrice: ${widget..price} \nOur HotLine Number: 0196-99-444-00\n";

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
                    },
                                  child: Icon(
                                    Icons.share,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                // popup menu
                                Spacer(),
                                PopupMenuButton(
                                  child: Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.zero,
                                  iconSize: 15,
                                  onSelected: (value) {
                                    if (value == 'Edit') {
                                      // Open Edit Popup
                                      navigateToEditPage(widget.id);
                                    } else if (value == 'Delete') {
                                      // Open Delete Popup
                                      //deleteById(id);
                                    } else if (value == 'edit price') {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PriceEditScreen()));
                                    }
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: Text("edit price"),
                                        value: 'edit price',
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

                               
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                
                ],
              ),
            ),
          )

          // Card(
          //   elevation: 7,
          //   child:      ListTile(
          //       contentPadding: EdgeInsets.only(left: 1, right: 1),

          //       title: ClipRRect(
          //         borderRadius: BorderRadius.circular(15),
          //         child: Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 5),
          //           child: Image.network(
          //             "https://pilotbazar.com/storage/vehicles/${widget.imageName}",
          //             width: 50,
          //             height: 100,
          //             fit: BoxFit.fill,
          //           ),
          //         ),
          //       ),
          //       //"https://pilotbazar.com/storage/vehicles/${products[x].imageName}"
          //       subtitle: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.max,
          //         children: [
          //           // product name
          //           Text(widget.vehiclaName.toString(),
          //               style: Theme.of(context).textTheme.bodyLarge),
          //           Row(
          //             children: [
          //               Text(
          //                 "R:",
          //                 style: Theme.of(context).textTheme.bodyLarge,
          //               ),
          //               Text(
          //                 widget.registration.toString(),
          //                 style: Theme.of(context).textTheme.bodyLarge,
          //               ),
          //               Text(
          //                 "",
          //                 style: Theme.of(context).textTheme.bodyLarge,
          //               ),
          //               Text(
          //                 " | ",
          //                 style: Theme.of(context).textTheme.bodyLarge,
          //               ),

          //               //Text(products[x].id.toString()),
          //               Text(
          //                 "fdf",
          //                 style: Theme.of(context).textTheme.bodyLarge,
          //               ),
          //               Text(
          //                 " | ",
          //                 style: Theme.of(context).textTheme.bodyLarge,
          //               ),
          //               Text(
          //                 "my write",
          //                 style: Theme.of(context).textTheme.bodyLarge,
          //               ),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "Available At (PBL)",
          //                 style: Theme.of(context).textTheme.bodyLarge,
          //               ),
          //               Spacer(),
          //               InkWell(
          //                 onTap: (){},
          //                 child: Icon(Icons.share,size: 20,))
          //               // IconButton(
          //               //   padding: EdgeInsets.zero,
          //               //   onPressed: () {},
          //               //   icon: Icon(
          //               //     Icons.share,
          //               //     size: 12,
          //               //   ),
          //               // )
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Text(
          //                 "Tk.",
          //                 style: TextStyle(height: 0,fontSize: 10),
          //               ),
          //               Text(
          //                 "gfg",
          //                 style: Theme.of(context).textTheme.bodyLarge,
          //               ),

          //               // ElevatedButton(

          //               //   onPressed: () async {
          //               //     final uri = Uri.parse(
          //               //         "https://pilotbazar.com/storage/vehicles/${widget.imageName}");
          //               //     final response = await http.get(uri);
          //               //     final imageBytes = response.bodyBytes;
          //               //     final tempDirectory = await getTemporaryDirectory();
          //               //     final tempFile =
          //               //         await File('${tempDirectory.path}/sharedImage.jpg')
          //               //             .create();
          //               //     await tempFile.writeAsBytes(imageBytes);

          //               //     final image = XFile(tempFile.path);
          //               //     await Share.shareXFiles([image],
          //               //         text:
          //               //             "Vehicle Name: ${widget.vehiclaName} \nManufacture:  ${widget.manufacture} \nConditiion: ${widget.condition} \nRegistration: ${widget.registration} \nMillage: ${widget.nMillage}, \nOur HotLine Number: 017xxxxxxxx");
          //               //   },
          //               //   child: Icon(Icons.share,size: 15,),
          //               // ),
          //             ],
          //           ),
          //           Text('d'),
          //         ],
          //       ),
          //     ),
          // ),

          ),
    );
  }

  navigateToEditPage(int index) {
    final route = MaterialPageRoute(
        builder: (context) => EditScreen(
              name: widget.vehiclaName.toString(),
              price: widget.price.toString(),
              registration: widget.registration,
              condition: widget.condition,
              mileage: widget.nMillage,
            ));
    Navigator.push(context, route);
  }

  navigateToPriceEditPage(int index) {
    final route = MaterialPageRoute(
        builder: (context) => PriceEditScreen(
              id: widget.id,
              name: widget.nMillage.toString(),
              price: widget.price.toString(),
              purchase_price: widget.purchase_price,
              fixed_price: widget.fixed_price,
            ));
    Navigator.push(context, route);
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlartDialogPage();
      },
    );
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

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/screens/edit_price.dart';
import 'package:pilot_refresh/screens/advance_edit_screen.dart';
import 'package:pilot_refresh/advance/text_fild_select_box.dart';
import 'package:pilot_refresh/screens/vehicle-details.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';
import 'package:pilot_refresh/widget/image_class.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Item extends StatefulWidget {
  final bool? myAskingPrice;
  final int? id;
  final String? code;
  final String? imageName;
  final String? price;
  final String? purchase_price;
  final String? fixed_price;
  final String? available;

  final String? vehiclaName;
  final String? brandName;
  final String? registration;
  final String? manufacture;
  final String? condition;
  final String? nMillage;
  final String? engine;
  final String? transmission;
  final String? model;
  final String? carModel;
  final String? fuel;
  final String? skeleton;

  final String? termAndCondition;
  final String? detailsLink;
  final String? carColor;
  final String? edition;
  final String? grade;
  final String? engineNumber;
  final String? chassisNumber;
  final String? video;
  final String? engine_id;
  final String? onlyMileage;
  final String? engines;
  final String? vehiclaNameModel;
  Item({
    this.id,
    this.imageName,
    this.code,
    this.price,
    this.purchase_price,
    this.fixed_price,
    this.available,
    this.vehiclaName,
    this.brandName,
    this.registration,
    this.manufacture,
    this.condition,
    this.nMillage,
    this.engine,
    this.transmission,
    this.model,
    this.carModel,
    this.fuel,
    this.skeleton,
    this.termAndCondition,
    this.detailsLink,
    this.myAskingPrice,
    this.carColor,
    this.edition,
    this.grade,
    this.engineNumber,
    this.chassisNumber,
    this.video,
    this.engine_id,
    this.onlyMileage,
    this.engines,
    this.vehiclaNameModel,
  });

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
  late int id;

  late String detailsLink;
  // bool myAskingPrice=false;
  bool? priceBool;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Image name");
    print(widget.imageName);
  }

  Future getLink(String id) async {
    print("This is get Link methode");
    prefss = await SharedPreferences.getInstance();
    Response response1 = await get(
        Uri.parse(
            "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${prefss.getString('token')}'
        });
    final Map<String, dynamic> decodedResponse1 = jsonDecode(response1.body);
    detailsLink = decodedResponse1['message'];
    print(detailsLink);
    setState(() {});
  }

  bool _detailsInProgress = false;
  static List unicTitle = [];
  static List details = [];
  static List imageLInk = [];
  late String ImageLink;
  late List ImageLinkList = [];

  bool _getDataInProgress = false;
  bool imageInProgress = false;

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
    detailsLink = decodedResponse['message'];
    setState(() {});

    List<dynamic> vehicleFeatures =
        decodedResponse['payload']['vehicle_feature'];

    List<FeatureDetailPair> featureDetailPairs =
        extractFeatureDetails(vehicleFeatures);

    for (var pair in featureDetailPairs) {
      unicTitle.add(pair.featureTitle);
      details.add(pair.detailTitles.join(', '));
    }

    if (mounted) {
      setState(() {});
    }

    _getDataInProgress = false;
    if (mounted) {
      setState(() {});
    }
    //return unicTitle+details;
    print("Length of ImageLInkList is");
    print(ImageLinkList.length);
  }

  static List showImageList = [];

  Future<void> sendWhatsImage(int id) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();

    ImageLinkList.clear();
    try {
      Response response1 = await get(
          Uri.parse(
              "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });
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
          "Vehicle Name: ${widget.vehiclaName} \nManufacture:  ${widget.manufacture} \nCondition: ${widget.condition} \nRegistration: ${widget.registration} \nMileage: ${widget.nMillage}, \nPrice: ${widget.price} \nOur HotLine Number: 0196-99-444-00\n \n See Details \n";

      // if (unicTitle.length != 0) {
      //   info = "\n${unicTitle[0]} : ${details[0]}";
      //   _detailsInProgress = true;
      //   setState(() {});
      //   for (int b = 1; b < unicTitle.length; b++) {
      //     info += "\n${unicTitle[b]} : ${details[b]}";
      //   }
      // }

      if (showImageList.isNotEmpty) {
        // Share all images with text
        await Share.shareXFiles(
          showImageList.map((image) => image as XFile).toList(),
        );

        // Clear lists and reset state

        ImageLinkList.clear();
        showImageList.clear();
        _detailsInProgress = false;
        imageInProgress = false;
    if (mounted) {
      setState(() {});
    }

        setState(() {});
      } else {
        print("No images to share.");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  TextStyle popubItem = TextStyle(color: Colors.black87, fontFamily: 'Roboto');

// Share with Email

  Future<void> shareViaEmail(String id) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    showImageList.clear();
    try {
      Response response1 = await get(
          Uri.parse(
              "https://pilotbazar.com/api/merchants/vehicles/products/$id/detail"),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${prefss.getString('token')}'
          });
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

      //List<XFile> showImageList = [];
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
          "Vehicle Name: ${widget.vehiclaName} \nManufacture:  ${widget.manufacture} \nCondition: ${widget.condition} \nRegistration: ${widget.registration} \nMileage: ${widget.nMillage}, \nPrice: ${widget.price} \nOur HotLine Number: 0196-99-444-00\n \n See Details \n$detailsLink";

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
    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> shareDetailsWithOneImage() async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }
    //setState() {});
    final uri = Uri.parse(
        "https://pilotbazar.com/storage/vehicles/${widget.imageName}");
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
        "Vehicle Name: ${widget.vehiclaName} \nManufacture:  ${widget.manufacture} \nConditiion: ${widget.condition} \nRegistration: ${widget.registration} \nMillage: ${widget.nMillage}, \nPrice: ${widget.price} \nOur HotLine Number: 0196-99-444-00\n \n Show More\n $detailsLink";

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

  late SharedPreferences preffs;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
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
                      borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(30), left: Radius.circular(5)),
                      child: InkWell(
                        onTap: () {
                          print('Id');

                          print(widget.id);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VehicleDetails(
                                        id: widget.id ?? 0,
                                        vehicleName: widget.vehiclaName,
                                        detailsVehicleImageName:
                                            "https://pilotbazar.com/storage/vehicles/${widget.imageName}",
                                        price: widget.price,
                                        brandName: widget.brandName,
                                        engine: widget.engine,
                                        engines: widget.engines,
                                        detailsCondition: widget.condition,
                                        detailsMillege: widget.nMillage,
                                        detailsTransmission:
                                            widget.transmission,
                                        color: widget.code,
                                        term_and_edition: widget.edition,
                                        model: widget.model,
                                        detailsFuel: widget.fuel,
                                        skeleton: widget.skeleton,
                                        registration: widget.registration,
                                        detailsGrade: widget.grade,
                                        code: widget.code,
                                        detailsVehicleManufacture:
                                            widget.manufacture,
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Image.network(
                            "https://pilotbazar.com/storage/vehicles/${widget.imageName}",
                            width: 50,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    subtitle: InkWell(
                      onTap: () {
                        print("pressed");
                        print(widget.id);
                        // Alart Dialog is off now
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => AlartDialogClass(
                        //       id: widget.id,
                        //       vehicleName: widget.vehiclaName,
                        //       brandName: widget.brandName,
                        //       engine: widget.engine,
                        //       detailsCondition: widget.condition,
                        //       detailsMillege: widget.nMillage,
                        //       detailsTransmission: widget.transmission,
                        //       detailsFuel: widget.fuel,
                        //       skeleton: widget.skeleton,
                        //       registration: widget.registration,
                        //       detailsVehicleManuConditioin:
                        //           widget.manufacture.toString(),
                        //       detailsVehicleManufacture:
                        //           widget.manufacture.toString(),
                        //     ),
                        //   ),
                        // );
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Text(widget.id.toString(),style: TextStyle(fontSize: 20),),
                              Text(widget.vehiclaName.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 8)),

                              Row(
                                children: [
                                  // Text(
                                  //   widget.myAskingPrice.toString(),
                                  //   style: TextStyle(color: Colors.white),
                                  // ),
                                  Text(
                                    "R : ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 8),
                                  ),
                                  Text(
                                    widget.registration.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 8),
                                  ),
                                  Text(" | ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  Text(
                                    widget.condition.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 8),
                                  ),
                                  Text(
                                    " | ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 8),
                                  ),

                                  //Text(products[x].id.toString()),
                                  Text("m: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 8)),

                                  Text(widget.onlyMileage.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 8)),
                                  Text(' km',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(fontSize: 8)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //SizedBox(height: 10),
                                  Text(
                                    widget.available.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(fontSize: 8),
                                  ),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Tk: ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontSize: 10)),
                                      Text(
                                          widget.myAskingPrice!
                                              ? widget.price.toString()
                                              : widget.purchase_price
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontSize: 10)),
                                      Spacer(),

                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(221, 65, 64, 64),
                                        radius: 15,
                                        child: imageInProgress ?
                                          CircularProgressIndicator()
                                            : PopupMenuButton(
                                                child: Icon(
                                                  Icons.share,
                                                  color: Colors.white,
                                                  size: 17,
                                                ),
                                                onSelected: (value) async {
                                                  if (value == 'details') {
                                                    await getLink(
                                                        widget.id.toString());
                                                    shareDetailsWithOneImage();
                                                  } else if (value == 'image') {
                                                    sendWhatsImage(
                                                        widget.id ?? 0);
                                                  }

                                                  // else if (value == 'details') {
                                                  //   shareDetailsWithOneImage();
                                                  // }

                                                  else if (value == 'email') {
                                                    imageInProgress
                                                        ? Center(
                                                            child:
                                                                CircularProgressIndicator())
                                                        : {
                                                            getLink(widget.id
                                                                .toString()),
                                                            shareViaEmail(widget
                                                                .id
                                                                .toString())
                                                          };
                                                  } else if (value ==
                                                      'Availability') {
                                                    await getAvailability();
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    61,
                                                                    59,
                                                                    59),
                                                            title: Center(
                                                                child: Text(
                                                              "Availability",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall,
                                                            )),
                                                            content: Container(
                                                              height: double
                                                                  .infinity,
                                                              width: 350,
                                                              child: ListView
                                                                  .builder(
                                                                primary: false,
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    availableResponseList
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  final item =
                                                                      availableResponseList[
                                                                              index]
                                                                          as Map;
                                                                  return Expanded(
                                                                    child:
                                                                        Expanded(
                                                                      child: Expanded(
                                                                          child: ElevatedButton(
                                                                              onPressed: () async {
                                                                                print("this is car id");
                                                                                print(widget.id);
                                                                                updateAvailable(item['id'], index);
                                                                                Navigator.pop(context);
                                                                              },
                                                                              style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 97, 93, 90)),
                                                                              child: Text(item['translate'][0]['title'].toString(), style: Theme.of(context).textTheme.bodySmall))),
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: Icon(Icons
                                                                    .close),
                                                                color: Colors
                                                                    .white, // Set icon color
                                                              ),
                                                            ],
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    top: 8,
                                                                    right: 8,
                                                                    bottom: 0,
                                                                    left: 8),
                                                          );
                                                        });
                                                  }
                                                },
                                                itemBuilder: (context) {
                                                  return [
                                                    PopupMenuItem(
                                                      child: Text(
                                                          "Send One Image"),
                                                      value: 'details',
                                                      textStyle: popubItem,
                                                    ),
                                                    PopupMenuItem(
                                                      child: Text(
                                                          "Send All Image"),
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
                                      // popup menu
                                      Spacer(),
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(221, 65, 64, 64),
                                        radius: 15,
                                        child: PopupMenuButton(
                                          color: Colors.white,
                                          child: Icon(
                                            Icons.more_vert,
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.zero,
                                          iconSize: 15,
                                          onSelected: (value) async {
                                            if (value == 'Edit') {
                                              // Open Edit Popup
                                              navigateToAdvanceEditPage(
                                                  widget.id ?? 0);
                                            }
                                            // if (value == 'Delete') {
                                            // Open Delete Popup
                                            //deleteById(id);
                                            // }
                                            if (value == 'Edit price') {
                                              navigateToAdvancePage(
                                                  widget.id ?? 0);
                                            } else if (value == 'Booked') {
                                              updateBooked(widget.id ?? 0);
                                            } else if (value == 'Sold') {
                                              updateSold(widget.id ?? 0);
                                            } else if (value ==
                                                'Availability') {
                                              await getAvailability();
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          const Color.fromARGB(
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
                                                              availableResponseList
                                                                  .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final item =
                                                                availableResponseList[
                                                                        index]
                                                                    as Map;
                                                            return Expanded(
                                                                child:
                                                                    ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          print(
                                                                              "this is car id");
                                                                          print(
                                                                              widget.id);
                                                                          updateAvailable(
                                                                              item['id'],
                                                                              widget.id ?? 0);
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        style: ElevatedButton.styleFrom(
                                                                            backgroundColor: Color.fromARGB(
                                                                                255,
                                                                                97,
                                                                                93,
                                                                                90)),
                                                                        child: Text(
                                                                            item['translate'][0]['title']
                                                                                .toString(),
                                                                            style:
                                                                                Theme.of(context).textTheme.bodySmall)));
                                                          },
                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        IconButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon:
                                                              Icon(Icons.close),
                                                          color: Colors
                                                              .white, // Set icon color
                                                        ),
                                                      ],
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 8,
                                                              right: 8,
                                                              bottom: 0,
                                                              left: 8),
                                                    );
                                                  });
                                            } else if (value == 'Advance') {
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TextFildSelectBox(
                                                            id: widget.id,
                                                            availableDD: widget
                                                                .available,
                                                            vehiclaName: widget
                                                                .vehiclaName,
                                                            vehiclaNameBangla:
                                                                widget
                                                                    .vehiclaName,
                                                            conditionValue:
                                                                widget
                                                                    .condition,
                                                            brandName: widget
                                                                .brandName,
                                                            fuel: widget.fuel,
                                                            skeleton:
                                                                widget.skeleton,
                                                            transmission: widget
                                                                .transmission,
                                                            registration: widget
                                                                .registration,
                                                            carColor:
                                                                widget.carColor,
                                                            edition:
                                                                widget.edition,
                                                            model: widget.model,
                                                            grade: widget.grade,
                                                            mileage: widget
                                                                .nMillage
                                                                .toString(),
                                                            engine: widget
                                                                .engine
                                                                .toString(),
                                                            purchase_price: widget
                                                                .purchase_price,
                                                            price: widget.price,
                                                            fixed_price: widget
                                                                .fixed_price,
                                                            engine_number: widget
                                                                .engineNumber,
                                                            chassis_number: widget
                                                                .chassisNumber,
                                                            code: widget.code,
                                                            video: widget.video
                                                                .toString(),
                                                            manufacture: widget
                                                                .manufacture,
                                                            engineId: widget
                                                                .engine_id,
                                                            onlyMileage: widget
                                                                .onlyMileage,
                                                            engines:
                                                                widget.engines,
                                                          )));
                                              // navigateToAdvanceEditPage(
                                              //     widget.id ?? 0);
                                            } else if (value == 'Delete') {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                5), // Remove rounded corners
                                                      ),
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255, 61, 59, 59),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 50,
                                                              vertical: 20),
                                                      title: Center(
                                                          child: Text(
                                                        "Do you want to delete?",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge,
                                                      )),
                                                      // titlePadding: EdgeInsets.only(top: 20),
                                                      content: Row(
                                                        children: [
                                                          SizedBox(height: 10),
                                                          Spacer(),
                                                          TextButton(
                                                            onPressed: () {},
                                                            child: Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {},
                                                            child: Text(
                                                              'No',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
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
                                              PopupMenuItem(
                                                child: Text("Edit price"),
                                                value: 'Edit price',
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
                                              // PopupMenuItem(
                                              //   child: Text("Edit"),
                                              //   value: 'Edit',
                                              // ),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  // Update Booked
   updateBooked(int index) async {
    prefss = await SharedPreferences.getInstance();
    final body = {
      "available_id": 20,
    };

    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/${widget.id}/update/booked";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });
    print(response.statusCode);
    print(widget.id);

    if (response.statusCode == 200) {
      print("Succesfully Booked");
    }
  }


  // Update Sold
  void updateSold(int index) async {
    prefss = await SharedPreferences.getInstance();
    final body = {
      "available_id": 22,
    };
    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/${widget.id}/update/sold";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    }
    );
    print(response.statusCode);
    print(widget.id);

    if (response.statusCode == 200) {
      print("Succesfully Sold");
    }
  }

  navigateToAdvanceEditPage(int index) {
    final route = MaterialPageRoute(
        builder: (context) => AdvanceScreen(
              name: widget.vehiclaName.toString(),
              price: widget.price.toString(),
              registration: widget.registration,
              condition: widget.condition,
              mileage: widget.nMillage,
            ));
    Navigator.push(context, route);
  }

  navigateToTextSelectBox() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TextFildSelectBox(
                  id: widget.id?.toInt(),
                )));
  }

  navigateToAdvancePage(int index) {
    final route = MaterialPageRoute(
        builder: (context) => PriceEditScreen(
              id: widget.id,
              name: widget.vehiclaName.toString(),
              price: widget.price.toString(),
              purchase_price: widget.purchase_price,
              fixed_price: widget.fixed_price,
            ));
    Navigator.push(context, route);
  }

  void updateAvailable(int availableID, int index) async {
    preffs = await SharedPreferences.getInstance();
    final body = {
      "available_id": availableID,
    };
    final url =
        "https://pilotbazar.com/api/merchants/vehicles/products/${widget.id}/available";
    final uri = Uri.parse(url);
    final response = await http.put(uri, body: jsonEncode(body), headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${preffs.getString('token')}'
    });
    print(response.statusCode);
    print(widget.id);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print("Succesfully Update");
    }
  }

  late SharedPreferences prefss;
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
}

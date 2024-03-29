import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pilot_refresh/For_Customer_Care/screens/C_bottom_nav_base_screen.dart';
import 'package:pilot_refresh/screens/edit_price.dart';
import 'package:pilot_refresh/screens/advance_edit_screen.dart';
import 'package:pilot_refresh/advance/text_fild_select_box.dart';
import 'package:pilot_refresh/screens/vehicle-details.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class C_Item extends StatefulWidget {
  final bool? showAskingPrice;
  final String? toki;
  final int? id;
  final String? code;
  final String? imageName;
  final String? price;
  final String? purchase_price;
  final String? fixed_price;
  final String? new_price;
  final String? available;
  final bool? isLoggedIn;
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
  final String? token;
  final String? fixedOrAskingPrice;

  C_Item({
    this.id,
    this.imageName,
    this.code,
    this.toki,
    this.price,
    this.purchase_price,
    this.fixed_price,
    this.new_price,
    this.available,
    this.vehiclaName,
    this.brandName,
    this.registration,
    this.manufacture,
    this.condition,
    this.nMillage,
    this.isLoggedIn,
    this.engine,
    this.transmission,
    this.model,
    this.carModel,
    this.fuel,
    this.skeleton,
    this.termAndCondition,
    this.detailsLink,
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
    this.token,
    this.fixedOrAskingPrice,
    this.showAskingPrice,
  });

  @override
  State<C_Item> createState() => _C_ItemState();
}

class _C_ItemState extends State<C_Item> {
  // yVjInK9erYHC0iHW9ehY8c6J4y79fbNzCEIWtZvQ.jpg
  //https://pilotbazar.com/storage/vehicles/
  late int id;

  String? detailsLink;
  // bool myAskingPrice=false;
  bool? priceBool;
  bool? logBool;

  int getIntPreef = 0;
  late SharedPreferences pre;

  Future<void> getPreffs() async {
    pre = await SharedPreferences.getInstance();
    if (pre.getString('token') == null) {
      getIntPreef--;
    } else {
      getIntPreef++;
    }
  }

  @override
  void initState() {
    print(widget.new_price);
    print(widget.price);
    super.initState();
    print("get prefs bool is");
    initializePreffsBool();
  }

  void initializePreffsBool() async {
    await getPreffs();
    setState(() {
      print(getIntPreef);
    });
  }

  bool imageInProgress = false;

  Future getLink(String id) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    print("get Link start bool ${imageInProgress}");

    preffs = await SharedPreferences.getInstance();

    print("This is get Link methode");
    prefss = await SharedPreferences.getInstance();
    Response? response1;
    if (preffs.getString('token') == null) {
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

  static List unicTitle = [];
  static List details = [];
  late String ImageLink;
  late List ImageLinkList = [];

  bool enterDetailsMethodeWithLotsOfDetails = false;

  Future getDetails(int id) async {
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

    if (mounted) {
      setState(() {});
    }
    //return unicTitle+details;
    print("Length of ImageLInkList is");
    print(ImageLinkList.length);
  }

  Future newGetDetails(int id) async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    print("get details start bool ${imageInProgress}");

    print("get details methode");
    prefss = await SharedPreferences.getInstance();

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
            'Authorization': 'Bearer ${pre.getString('token')}'
          });
    }
    print("Get Details methodes");
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);
    List<dynamic> vehicleFeatures =
        decodedResponse['payload']['vehicle_feature'];

    List<FeatureDetailPair> featureDetailPairs =
        extractFeatureDetails(vehicleFeatures);
    if (featureDetailPairs.isNotEmpty) {
      enterDetailsMethodeWithLotsOfDetails = true;
      if (mounted) {
        setState(() {});
      }
    }

    for (var pair in featureDetailPairs) {
      unicTitle.add(pair.featureTitle);
      details.add(pair.detailTitles.join(', '));
    }
    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
    print("get details last bool ${imageInProgress}");
    print("details length is");
    print(details.length);
    print("End get details methode");
  }

  List<XFile> showImageList = [];

  Future<void> shareAllImages() async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    Response? response1;
    try {
      if (prefss.getString('token') == null) {
        response1 = await get(
          Uri.parse(
              "https://pilotbazar.com/api/clients/vehicles/products/${widget.id}/detail"),
        );
      } else {
        response1 = await get(
            Uri.parse(
                "https://pilotbazar.com/api/merchants/vehicles/products/${widget.id}/detail"),
            headers: {
              'Accept': 'application/vnd.api+json',
              'Content-Type': 'application/vnd.api+json',
              'Authorization': 'Bearer ${prefss.getString('token')}'
            });
      }
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

      if (showImageList.isNotEmpty) {
        await Share.shareXFiles(
          showImageList.map((image) => image as XFile).toList(),
        );

        // Clear lists and reset state
        unicTitle.clear();
        details.clear();
        ImageLinkList.clear();
        showImageList.clear();
        imageInProgress = false;
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

  TextStyle popubItem = TextStyle(color: Colors.black87, fontFamily: 'Roboto');

  bool emailInProgress = false;

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

    String message =
        "${widget.vehiclaName},Manufacture: ${widget.manufacture}, ${widget.condition}, Registration:${widget.registration},Mileage: ${widget.nMillage},price:${getIntPreef > 0 ? widget.showAskingPrice??true ? widget.price : widget.fixed_price : widget.new_price} ";
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
        "\nOut HotLine Number ${prefss.getString('mobileNumber')}\nShow More\n $detailsLink";

    setState(() {});
    await Share.shareXFiles([image], text: message + message2 + message3);
    unicTitle.clear();
    details.clear();

    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> shareOnlyDetailsForMedia() async {
    imageInProgress = true;
    if (mounted) {
      setState(() {});
    }
    prefss = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }

    String message =
        "${widget.vehiclaName},Manufacture: ${widget.manufacture}, ${widget.condition}, Registration:${widget.registration},Mileage: ${widget.nMillage},} ";
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
    await Share.share(message + message2);

    imageInProgress = false;
    unicTitle.clear();
    details.clear();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> shareOnlyDetailsWithLink() async {
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

    String message =
        "${widget.vehiclaName},Manufacture: ${widget.manufacture}, ${widget.condition}, Registration:${widget.registration},Mileage: ${widget.nMillage}, Price: ${getIntPreef > 0 ? widget.showAskingPrice??true? widget.price : widget.fixed_price : widget.new_price} ";
    String message2 = '';
    for (int i = 0; i < details.length; i++) {
      message2 += " ${details[i]}";
      if (i < details.length - 1) {
        message2 += ", "; // Add a comma and space if it's not the last index
      }
    }
    String message3 = "\nOut HotLine Number ${prefss.getString('mobileNumber')}\nShow More\n $detailsLink";

    setState(() {});
    await Share.share(message + message2 + message3);
    unicTitle.clear();
    details.clear();

    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> shareMedia() async {
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
        "Vehicle Name: ${widget.vehiclaName} \nManufacture:  ${widget.manufacture} \nConditiion: ${widget.condition} \nRegistration: ${widget.registration} \nMillage: ${widget.nMillage}, \nOur HotLine Number: 0196-99-444-00";

    if (unicTitle.length != 0) {
      info = "\n${unicTitle[0]} : ${details[0]}";

      setState(() {});
      for (int b = 1; b < unicTitle.length; b++) {
        info += "\n${unicTitle[b]} : ${details[b]}";
      }
    }
    await Share.shareXFiles([image], text: message);
    //"Vehicle Name: ${products[x].vehicleName} \nManufacture:  ${products[x].manufacture} \nConditiion: ${products[x].condition} \nRegistration: ${products[x].registration} \nMillage: ${products[x].mileage}, \nPrice: ${products[x].price} \nOur HotLine Number: 017xxxxxxxx\n"
    unicTitle.clear();
    details.clear();
    imageInProgress = false;
    if (mounted) {
      setState(() {});
    }
    setState(() {});
  }

  late SharedPreferences preffs;
  double? shareSize;
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
                          right: Radius.circular(5), left: Radius.circular(5)),
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
                                        color: widget.carColor,
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
                        child: Image.network(
                          "https://pilotbazar.com/storage/vehicles/${widget.imageName}",
                          width: 60,
                          height: 110,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                
                    subtitle: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      
                          Text(widget.vehiclaName.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontSize: 8)),
                          Row(
                            children: [
                           
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
                                  style: Theme.of(context).textTheme.bodyLarge),
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

                                

                                  getIntPreef > 0
                                      ? Text(
                                          widget.price.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontSize: 10),
                                        )
                                      : Text(
                                          widget.new_price.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(fontSize: 10),
                                        ),

                                  Spacer(),
                                 
                                  (imageInProgress || emailInProgress)
                                      ? SizedBox(
                                        height: 19,width: 19,
                                        child: CircularProgressIndicator(strokeWidth: 3,))
                                      : PopupMenuButton(
                                          child: Icon(
                                            Icons.share,
                                            color: Colors.white,
                                            size: 19,
                                          ),
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Send as Visitor',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: Colors.black,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      await newGetDetails(
                                                          widget.id ?? 12);
                                                      await getLink(await widget
                                                          .id
                                                          .toString());
                                                      await shareDetailsWithOneImage();
                                                      Navigator.pop(context);
                                                    },
                                                    child: insidePopubButton(context,
                                                        "Taka, Link, Details, Image  "),
                                                  ),
                                                  SizedBox(width: 10),
                                                  SizedBox(height: 10),
                                                  InkWell(
                                                    child: insidePopubButton(context,
                                                        "Taka, Link, Details"),
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      await newGetDetails(
                                                          widget.id ?? 12);
                                                      await getLink(
                                                          widget.id.toString());
                                                      await shareOnlyDetailsWithLink();

                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  SizedBox(height: 10),
                                                  SizedBox(height: 10),
                                                  Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Send as Media (মিডিয়া)',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: Colors.black,
                                                  ),
                                                  InkWell(
                                                    child: insidePopubButton(context,
                                                        "All Images (শুধু ছবি)"),
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      await shareAllImages();
                                                     
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  SizedBox(height: 10),
                                                  InkWell(
                                                      onTap: () async {
                                                      
                                                        Navigator.pop(context);

                                                        await newGetDetails(
                                                            widget.id ?? 12);
                                                        await getLink(widget.id
                                                            .toString());
                                                        await shareOnlyDetailsForMedia();
                                                      },
                                                      child: insidePopubButton(
                                                          context,
                                                          "Details (শুধু তথ্য)")),
                                                ],
                                              ))
                                            ];
                                          }),


                                  (getIntPreef == 1) ? Spacer() : Container(),
                                  (getIntPreef == 1)
                                      ? PopupMenuButton(
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
                                            // if (value == 'Edit price') {
                                            //   navigateToAdvancePage(
                                            //       widget.id ?? 0);
                                            // } 
                                            
                                            else if (value == 'Booked') {
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
                                                                .registration
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
                                              print("Id is ${widget.id}");
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
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontFamily:
                                                                'Axiforma'),
                                                      )),
                                                      // titlePadding: EdgeInsets.only(top: 20),
                                                      content: Row(
                                                        children: [
                                                          SizedBox(height: 10),
                                                          Spacer(),
                                                          TextButton(
                                                            onPressed:
                                                                () async {
                                                              await deleteMethode(
                                                                  widget.id ??
                                                                      0);
                                                            },
                                                            child: Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Axiforma'),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'No',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Axiforma'),
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
                                              // PopupMenuItem(
                                              //   child: Text("Edit price"),
                                              //   value: 'Edit price',
                                              //   textStyle: popubItem,
                                              // ),
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
                                  (getIntPreef != 1 || getIntPreef <= 0)
                                      ? SizedBox(width: 20)
                                      : SizedBox()
                                ],
                              ),
                            ],
                          ),
                        ],
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
    });

    if (response.statusCode == 200) {
    }
  }

  deleteMethode(int id) async {
    prefss = await SharedPreferences.getInstance();
    //  final body = {
    //   "delete_id": 1,
    // };
    final url = "https://pilotbazar.com/api/merchants/vehicles/products/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri, headers: {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss.getString('token')}'
    });

    if (response.statusCode == 200) {
      print("Succesfully Booked");
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>C_BottomNavBaseScreen()), (route) => false);
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

  Container insidePopubButton(BuildContext context, String name) {
    return Container(
      height: 25,
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          green10R,
           SizedBox(width: 10),
          Text(
            name,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
         
          
        ],
      ),
    );
  }

  Icon green10R = Icon(
    Icons.circle,
    color: Colors.green,
    size: 10,
  );
}


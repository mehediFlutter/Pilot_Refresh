import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';

class VehicleDetails extends StatefulWidget {
  final Map? todo;
  final List? ImageLinkListForVehicleDetails;
  final int id;
  final String? code;
  final String? brandName;
  final String? detailsVehicleManufacture;
  final String? detailsVehicleManuConditioin;
  final String? detailsVehicleImageName;
  final String? engine;
  final String? detailsCondition;
  final String? detailsMillege;
  final String? detailsTransmission;
  final String? detailsGrade;
  final String? model;
  final String? price;
  final String? vehicleName;
  final String? color;
  final String? term_and_edition;

  final String? dropdownFontLight;
  final String? dropdownFontLightAnswer;
  final String? dropdownSeat;
  final String? dropdownSeatAnswer;
  final String? dropdownRoof;
  final String? dropdownRoofAnswer;
  final String? dropdownStarOption;
  final String? dropdownStarOptionAnswer;
  final String? detailsFuel;
  final String? detailsRegistration;
  final String? skeleton;
  final String? registration;

  const VehicleDetails(
      {super.key,
      this.todo,
      this.ImageLinkListForVehicleDetails,
      required this.id,
      this.code,
      this.brandName,
      this.detailsVehicleManufacture,
      this.detailsVehicleManuConditioin,
      this.detailsVehicleImageName,
      this.engine,
      this.detailsCondition,
      this.detailsMillege,
      this.detailsTransmission,
      this.detailsFuel,
      this.detailsRegistration,
      this.detailsGrade,
      this.model,
      this.skeleton,
      this.registration,
      this.dropdownFontLight,
      this.dropdownFontLightAnswer,
      this.dropdownSeat,
      this.dropdownSeatAnswer,
      this.dropdownRoof,
      this.dropdownRoofAnswer,
      this.dropdownStarOption,
      this.dropdownStarOptionAnswer,
      this.price,
      this.color,
      this.term_and_edition,
      this.vehicleName});

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  bool _getDataInProgress = false;
  List unicTitle = [];
  List details = [];
  //final todo = widget.todo;

  void getDetails() async {
    _getDataInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Response response = await get(Uri.parse(
        "https://pilotbazar.com/api/merchants/vehicles/products/${widget.id}/detail"));
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
    for (int y = 0; y < unicTitle.length; y++) {
      print(
        unicTitle[y],
      );
      print(
        details[y],
      );
    }
  }

  static Map? todo;

  List<String> lessFeatureTitle = [];
  List<String> lessFeatureDetails = [];

  getFeature() {
    lessFeatureTitle.clear();
    lessFeatureDetails.clear();
    lessFeatureTitle.addAll([
      'Brand  ',
      'Model ',
      'Engine ',
      'Condition  ',
      'Mileage ',
      'Transmission ',
      'Color ',
      "Trim & Edition ",
      'Fuel ',
      'Skeleton ',
      'Registration ',
      'Grade ',
      'Manufacture'
    ]);

    lessFeatureDetails.addAll([
      widget.brandName.toString(),
      widget.model.toString(),
      widget.engine.toString(),
      widget.detailsCondition.toString(),
      widget.detailsMillege.toString(),
      widget.term_and_edition.toString(),
      widget.detailsTransmission.toString(),
      widget.color.toString(),
      widget.detailsFuel.toString(),
      widget.skeleton.toString(),
      widget.registration.toString(),
      widget.detailsGrade.toString(),
      widget.detailsVehicleManufacture.toString(),
    ]);

    setState(() {});
    print("length of less Feature Title");
    print(lessFeatureTitle.length);
    for (var index in lessFeatureTitle) {
      print(index);
    }
    for (var index in lessFeatureDetails) {
      print(index);
    }
  }

  List imageList = [];
  late String ImageLink;
  late List ImageLinkList = [];
  bool _getImages = false;
  Future<void> getImages() async {
    _getImages = true;
    if (mounted) {
      setState(() {});
    }
    Response response1 = await get(Uri.parse(
        "https://pilotbazar.com/api/merchants/vehicles/products/${widget.id}/detail"));
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
    print("List of Images list is ");
    print(ImageLinkList.length);
    _getImages = false;
    if (mounted) {
      setState(() {});
    }
  }

  Timer? _timer;

  void startAutoPlay() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentIndex < ImageLinkList.length - 1) {
        _pageController.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        setState(() {});
      } else {
        _pageController.jumpToPage(0);
        setState(() {});
      }
    });
  }

  void onTapImage(){
    if(_currentIndex<ImageLinkList.length-1){
      
    }
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
    getImages();
    todo = widget.todo;
    if (todo != null) {
      String name = todo?['vehicleName'] ?? '';
      print("Name is");
      print(name);
    }
    getFeature();
    _pageController = PageController(initialPage: 0);
    startAutoPlay();
    //getImages();
  }

  int _currentIndex = 0;
  PageController _pageController = PageController(initialPage: 0);

  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF313131),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    widget.vehicleName.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _getImages
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          CircularProgressIndicator(),
                          SizedBox(height: 30),
                          Text(
                            "Please wait images are loagind",
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 250,
                              width: double.infinity,
                              child: PageView.builder(
                                controller: _pageController,
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                                itemCount: ImageLinkList.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Image.network(
                                    'https://pilotbazar.com/storage/galleries/${ImageLinkList[index] ?? 'https://pilotbazar.com/storage/vehicles/${widget.detailsVehicleImageName.toString()}'}',
                                    width: double.infinity,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              left: 0,
                              child: IconButton(
                                onPressed: () {
                                  if (_currentIndex > 0) {
                                    _pageController.previousPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                icon: Icon(Icons.arrow_back, size: 60),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  if (_currentIndex <
                                      ImageLinkList.length - 1) {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_forward,
                                  size: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 10),
                Container(
                  height: 100,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: ImageLinkList.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          final newPageIndex = index;
                          if (newPageIndex <= ImageLinkList.length) {
                            _pageController.animateToPage(newPageIndex,
                                duration: Duration(microseconds: 300),
                                curve: Curves.easeInOut);
                          }
                          setState(() {});
                          print(index);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            'https://pilotbazar.com/storage/galleries/${ImageLinkList[index] ?? 'https://pilotbazar.com/storage/vehicles/${widget.detailsVehicleImageName.toString()}'}',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),

                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 178, 224, 179),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "BDT ${widget.price ?? ''}",
                        // "BDT  ${todo?['price']??''} Tk",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ),

                    subtitle: Text(
                      "Negotiable | T&C will be applicable",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),

                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(
                        //   height: 5,
                        // ),
                        Text("Code",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.black,fontSize: 15
                                )),
                        Text(
                            "${widget.code}"
                            // todo?['code']??''.toString()
                            ,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.black,fontSize: 10
                                )),
                      ],
                    ),

                    // trailing: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "Code",
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyMedium!
                    //           .copyWith(color: Colors.black, fontSize: 15),
                    //     ),
                    //     Expanded(
                    //         child: Text(
                    //       "PS-99",
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyMedium!
                    //           .copyWith(color: Colors.black, fontSize: 10),
                    //     )),
                    //   ],
                    // ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Text("Features :",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          decorationStyle: TextDecorationStyle.solid,
                        )),
                //     RichText(
                //   text: TextSpan(
                //     text: 'Features',
                //     style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 20,
                //       decoration: TextDecoration.underline,
                //     ),
                //   ),
                // ),

                // this is less feature and details
                Container(
                    width: double.infinity,
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: lessFeatureTitle.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                  child: Text(lessFeatureTitle[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall)),
                              //Text(":",style: TextStyle(color: Colors.white),),
                              SizedBox(
                                width: size.width / 20,
                              ),

                              Expanded(
                                  child: Text(lessFeatureDetails[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall)),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 4,
                        );
                      },
                    )),

                // Container(
                //   width: double.infinity,
                //   height: size.height / 2.7,
                //   child: Expanded(
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       children: [
                //         Expanded(
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               SizedBox(
                //                 height: size.height / 40,
                //               ),
                //               features_unit_left_side(context, "Brand : ",
                //                   widget.brandName.toString()),
                //               features_unit_left_side(
                //                   context, "Model : ", widget.model.toString()),
                //               features_unit_left_side(context, "Engine : ",
                //                   widget.engine.toString()),
                //               features_unit_left_side(context, "Condition : ",
                //                   widget.detailsCondition.toString()),
                //               features_unit_left_side(context, "Mileage : ",
                //                   widget.detailsMillege.toString()),
                //               Row(
                //                 children: [
                //                   Text("Transmission : ",
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .bodyMedium!
                //                           .copyWith(fontSize: 12)),
                //                   Expanded(
                //                       child: Text(
                //                           widget.detailsTransmission.toString(),
                //                           style: Theme.of(context)
                //                               .textTheme
                //                               .bodyMedium!
                //                               .copyWith(fontSize: 12))),
                //                   SizedBox(
                //                     height: 10,
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(height: 20),
                //               features_unit_left_side(
                //                   context, "Color : ", widget.color.toString()),
                //             ],
                //           ),
                //         ),
                //         Expanded(
                //           child: Align(
                //             alignment: Alignment.topRight,
                //             child: Column(
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 SizedBox(
                //                   height: size.height / 50,
                //                 ),
                //                 features_unit_right_side(
                //                     context,
                //                     "Trim & Edition : ",
                //                     widget.term_and_edition.toString()),
                //                 features_unit_right_side(context, "Fuel : ",
                //                     widget.detailsFuel.toString()),
                //                 features_unit_right_side(context,
                //                     "Skeleton  : ", widget.skeleton.toString()),
                //                 features_unit_right_side(
                //                     context,
                //                     "Registration :",
                //                     widget.registration.toString()),
                //                 features_unit_right_side(context, "Grade : ",
                //                     widget.detailsGrade.toString()),
                //                 features_unit_right_side(
                //                     context,
                //                     "Manufacture : ",
                //                     widget.detailsVehicleManufacture
                //                         .toString()),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 10,
                ),
                _getDataInProgress
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        "Special Features",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            // decoration: TextDecoration.underline,
                            decorationColor:
                                const Color.fromARGB(255, 175, 173, 173),
                            fontSize: 20),
                      ),

                Container(
                    width: double.infinity,
                    child: ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: unicTitle.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                  child: Text(unicTitle[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall)),
                              //Text(":",style: TextStyle(color: Colors.white),),
                              SizedBox(
                                width: size.width / 20,
                              ),

                              Expanded(
                                  child: Text(details[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall)),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          height: 4,
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  features_unit_left_side(
    BuildContext context,
    String title,
    String details,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          Text(details, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  features_unit_right_side(BuildContext context, String title, String details) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Spacer(),
          //SizedBox(height: 10,),
          Text(title, style: Theme.of(context).textTheme.bodySmall),
          Text(details, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

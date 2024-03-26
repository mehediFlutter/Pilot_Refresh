import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:photo_view/photo_view.dart';

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
  final String? engines;
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
      this.engines,
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
  SharedPreferences? Preffs;
  bool isDetailsEmpty = false;

  Future getDetails() async {
    Preffs = await SharedPreferences.getInstance();

    _getDataInProgress = true;
    if (mounted) {
      setState(() {});
    }

    Response? response;
    if (Preffs?.getString('token') == null) {
      response = await get(
        Uri.parse(
            "https://pilotbazar.com/api/clients/vehicles/products/${widget.id}/detail"),
      );
    } else {
      response = await get(
          Uri.parse(
              "https://pilotbazar.com/api/merchants/vehicles/products/${widget.id}/detail"),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${Preffs!.getString('token')}'
          });
    }
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
    print("Get Details methodes");
    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response!.body);
    if (decodedResponse['payload']['vehicle_feature'].length == 0) {
      isDetailsEmpty = true;
      setState(() {});
    }
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

  Future getImageLink() async {
    Preffs = await SharedPreferences.getInstance();
    Response? response;
    if (Preffs?.getString('token') == null) {
      response = await get(
        Uri.parse(
            'https://pilotbazar.com/api/clients/vehicles/products/${widget.id}/detail'),
      );
    } else {
      response = await get(
          Uri.parse(
              'https://pilotbazar.com/api/merchants/vehicles/products/${widget.id}/detail'),
          headers: {
            'Accept': 'application/vnd.api+json',
            'Content-Type': 'application/vnd.api+json',
            'Authorization': 'Bearer ${Preffs!.getString('token')}'
          });
    }
    print("This is getImageLink function Status Code");
    print(response.statusCode);
    print(response.body);

    final Map<String, dynamic> decodedResponse = jsonDecode(response!.body);
    List<dynamic> imageGallry = decodedResponse['payload']['gallery'];
    print("Length");
    print(imageGallry.length);
  }

  Future<void> getImages() async {
    Preffs = await SharedPreferences.getInstance();
    _getImages = true;
    if (mounted) {
      setState(() {});
    }
    Response? response1;
    if (Preffs?.getString('token') == null) {
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
            'Authorization': 'Bearer ${Preffs!.getString('token')}'
          });
    }
    print(response1?.statusCode);

    final Map<String, dynamic> decodedResponse1 = jsonDecode(response1!.body);
    List<dynamic> imageGallary = decodedResponse1['payload']['gallery'];

    imageGallary.forEach((e) {
      ImageLinkList.add(e['name']);
      //  ImageLink=e['name'];
      //ImageLinkList.add(ImageLink);
    });

    // for (int b = 0; b < decodedResponse1['payload']['gallery'].length; b++) {
    //   ImageLink = decodedResponse1['payload']["gallery"][b]?['name'] ?? '';
    //   ImageLinkList.add(ImageLink);
    // }

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
      // widget.term_and_edition.toString(),
      widget.detailsTransmission.toString(),
      widget.color.toString(),
      widget.term_and_edition.toString(),
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
  String? ImageLink;
  List ImageLinkList = [];
  bool _getImages = false;

  initState() {
    super.initState();
    print("hello i am in details page");
    print("ID ${widget.id}");

    getDetails();
    //  getImageLink();
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

  getimg() async {
    Response response = await get(
        Uri.parse(
            'https://pilotbazar.com/api/merchants/vehicles/products/${widget.id}/detail'),
        headers: {
          'Accept': 'application/vnd.api+json',
          'Content-Type': 'application/vnd.api+json',
          'Authorization': 'Bearer ${Preffs!.getString('token')}'
        });
    print('statuc cdoe');
    print(response.statusCode);
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

  void onTapImage() {
    if (_currentIndex < ImageLinkList.length - 1) {}
  }

  stopAutoPlay() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
  }

  restartAutoPlay() {
    if (_timer != null && !_timer!.isActive) {
      startAutoPlay();
    }
  }

  pressedImage() {}

  @override
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
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      body: Column(
                                        children: [
                                          Expanded(
                                            child: PhotoViewGallery.builder(
                                              itemCount:
                                                  ImageLinkList.length ?? 0,
                                              builder: (context, index) {
                                                return PhotoViewGalleryPageOptions(
                                                  imageProvider: NetworkImage(
                                                    'https://pilotbazar.com/storage/galleries/${ImageLinkList[index] ?? 'https://pilotbazar.com/storage/vehicles/${widget.detailsVehicleImageName.toString()}'}',
                                                  ),
                                                  minScale:
                                                      PhotoViewComputedScale
                                                          .contained,
                                                  maxScale:
                                                      PhotoViewComputedScale
                                                              .covered *
                                                          2,
                                                );
                                              },
                                              backgroundDecoration:
                                                  BoxDecoration(
                                                color: Colors.black,
                                              ),
                                              pageController: PageController(
                                                initialPage: _currentIndex,
                                              ),
                                              onPageChanged: (index) {
                                                setState(() {
                                                  _currentIndex = index;
                                                });
                                              },
                                            ),
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                stopAutoPlay();
                              },
                              onLongPressEnd: (details) {
                                restartAutoPlay(); // Restart auto-scrolling when long press ends
                              },
                              child: Container(
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
                                    return PhotoView(
                                      imageProvider: NetworkImage(
                                          'https://pilotbazar.com/storage/galleries/${ImageLinkList[index] ?? 'https://pilotbazar.com/storage/vehicles/${widget.detailsVehicleImageName.toString()}'}'),
                                      minScale:
                                          PhotoViewComputedScale.contained *
                                              1.1, // Adjust as needed
                                    );
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              left: -10,
                              child: Container(
                                padding: EdgeInsets.all(
                                    8.0), // Adjust the padding as needed
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent),
                                  onPressed: () {
                                    if (_currentIndex > 0) {
                                      _pageController.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              // top: 20,
                              right: -10,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent),
                                onPressed: () {
                                  if (_currentIndex <
                                      ImageLinkList.length - 1) {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                child: Icon(
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
                                .copyWith(color: Colors.black, fontSize: 15)),
                        Text(
                            "${widget.code}"
                            // todo?['code']??''.toString()
                            ,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.black, fontSize: 10)),
                      ],
                    ),

                    
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

               
                SizedBox(
                  height: 10,
                ),
               isDetailsEmpty?SizedBox(): Text(
                        "Special Features",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            // decoration: TextDecoration.underline,
                            decorationColor:
                                const Color.fromARGB(255, 175, 173, 173),
                            fontSize: 20),
                      ),

              isDetailsEmpty?SizedBox():  Container(
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

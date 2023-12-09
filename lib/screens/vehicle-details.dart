import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';

class VehicleDetails extends StatefulWidget {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF313131),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
            child: Column(
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
                Card(
                    elevation: 20,
                    color: Color(0xFF313131),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            widget.detailsVehicleImageName.toString() ?? ""))),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 178, 224, 179),
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    title: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "BDT  ${widget.price} Tk",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    
                    subtitle: Text(
                      "Negotiable | T&C will be applicable",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 15,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),

                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text("Code",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.black,)),
                        Text(widget.code.toString(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.black,)),
                        
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

                Container(
                  width: double.infinity,
                  height: size.height / 2.7,
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height / 40,
                              ),
                              features_unit_left_side(context, "Brand : ",
                                  widget.brandName.toString()),
                              features_unit_left_side(
                                  context, "Model : ", widget.model.toString()),
                              features_unit_left_side(context, "Engine : ",
                                  widget.engine.toString()),
                              features_unit_left_side(context, "Condition : ",
                                  widget.detailsCondition.toString()),
                              features_unit_left_side(context, "Mileage : ",
                                  widget.detailsMillege.toString()),
                              Row(
                                children: [
                                  Text("Transmission : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 12)),
                                  Expanded(
                                      child: Text(
                                          widget.detailsTransmission.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(fontSize: 12))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                               SizedBox(height: 20),
                              features_unit_left_side(
                                  context, "Color : ", widget.color.toString()),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: size.height / 50,
                                ),
                                features_unit_right_side(
                                    context,
                                    "Trim & Edition : ",
                                    widget.term_and_edition.toString()),
                                features_unit_right_side(context, "Fuel : ",
                                    widget.detailsFuel.toString()),
                                features_unit_right_side(context,
                                    "Skeleton  : ", widget.skeleton.toString()),
                                features_unit_right_side(
                                    context,
                                    "Registration :",
                                    widget.registration.toString()),
                                features_unit_right_side(context, "Grade : ",
                                    widget.detailsGrade.toString()),
                                features_unit_right_side(
                                    context,
                                    "Manufacture : ",
                                    widget.detailsVehicleManufacture
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _getDataInProgress
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        "Special Features",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  const Color.fromARGB(255, 175, 173, 173),
                            ),
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

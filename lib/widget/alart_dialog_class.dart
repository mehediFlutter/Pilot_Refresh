import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';

class AlartDialogClass extends StatefulWidget {
  final int id;
  final String? brandName;
  final String? model;
  final String? engine;
  final String? detailsVehicleManuConditioin;

  final String? detailsVehicleImageName;

  final String? detailsCondition;
  final String? detailsMillege;

  final String? detailsTransmission;
  final String? color;
  final String? term_and_edition;
  final String? detailsVehicleManufacture;
  final String? detailsFuel;
  final String? skeleton;
  final String? registration;
  final String? detailsGrade;
  final String? vehicleName;
  final String? detailsRegistration;

  AlartDialogClass(
      {super.key,
      required this.id,
      required this.vehicleName,
      this.brandName,
      this.detailsVehicleManufacture,
      this.detailsVehicleManuConditioin,
      this.detailsVehicleImageName,
      this.engine,
      this.detailsCondition,
      this.detailsMillege,
      this.detailsTransmission,
      this.detailsGrade,
      this.model,
      this.color,
      this.term_and_edition,
      this.detailsFuel,
      this.detailsRegistration,
      this.skeleton,
      this.registration});

  @override
  State<AlartDialogClass> createState() => _AlartDialogClassState();
}

class _AlartDialogClassState extends State<AlartDialogClass> {
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
  }

  List featureDetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
    featureDetails = [
      widget.brandName ?? '',
      widget.model ?? '-',
      widget.engine ?? '-',
      widget.detailsCondition ?? '-',
      widget.detailsMillege ?? '-',
      widget.detailsTransmission ?? '-',
      widget.color ?? '-',
      widget.term_and_edition ?? '',
      widget.detailsFuel ?? '-',
      widget.skeleton ?? '-',
      widget.registration ?? '-',
      widget.detailsGrade ?? '-',
      widget.detailsVehicleManufacture ?? '-',
    ];
  }

  features_unit_left_side(
    BuildContext context,
    String title,
    String details,
  ) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
                child:
                    Text(title, style: Theme.of(context).textTheme.bodySmall)),
            Expanded(
                child: Text(details,
                    style: Theme.of(context).textTheme.bodySmall)),
          ],
        ),
      ),
    );
  }

  List<String> featuresTitle = [
    'Brand : ',
    'Model : ',
    'Engine : ',
    'Condition : ',
    'Mileage : ',
    'Transmission : ',
    'color : ',
    'Trim & Edition : ',
    'Fuel : ',
    'Skeletio : ',
    'Registration : ',
    'Grade : ',
    'Manufacture : '
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF313131),
        body: Center(child: detailsAlartDialog(context)));
  }

  AlertDialog detailsAlartDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF313131),
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Details of ${widget.vehicleName.toString()}",
            style: Theme.of(context).textTheme.titleMedium,
          ),

          SizedBox(height: 7),

          // ListView.builder(
          //     primary: false,
          //     shrinkWrap: true,
          //     itemCount: featuresTitle.length,
          //     itemBuilder: (context, index) {
          //       return features_unit_left_side(
          //           context, featuresTitle[index], featureDetails[index]);
          //     }),

          // features_unit_left_side(context, "Model : ", "FFDFDF"),
          // features_unit_left_side(context, "En :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          // features_unit_left_side(context, "FDFSDF :", "FFDFDF"),
          SizedBox(height: 7),
        ],
      ),
      content: _getDataInProgress
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Features: ",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 5),
                    ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: featuresTitle.length,
                      itemBuilder: (context, index) {
                        return features_unit_left_side(
                            context,
                            featuresTitle[index].toString(),
                            featureDetails[index].toString());
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Divider(
                            height: 8,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20,bottom: 10),
                      child: Text(
                        'Special Features :',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 500,
                      width: 350,
                      child: ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: unicTitle.length,
                        itemBuilder: (context, index) {
                          return Expanded(
                            child: ListTile(
                              title: Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      unicTitle[index].toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                    Expanded(
                                        child: Text(
                                      details[index].toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            height: 4,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
          color: Colors.white, // Set icon color
        ),
      ],
    );
  }
}

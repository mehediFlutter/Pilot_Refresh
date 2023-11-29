import 'package:flutter/material.dart';

class VehicleDetails extends StatefulWidget {
  final String? brandName;
  final String detailsVehicleManufacture;
  final String detailsVehicleManuConditioin;
  final String detailsVehicleImageName;
  final String? detailsEngine;
  final String? detailsCondition;
  final String? detailsMillege;
  final String? detailsTransmission;
  final String? detailsGrade;
  final String? model;
  final String? price;
  final String? vehicleName;

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
      this.brandName,
      required this.detailsVehicleManufacture,
      required this.detailsVehicleManuConditioin,
      required this.detailsVehicleImageName,
      this.detailsEngine,
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
      this.vehicleName});

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40,left: 15,right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.vehicleName.toString(),style: TextStyle(fontSize: 20),),
                SizedBox(height: 20,),
                Image.network(widget.detailsVehicleImageName),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 178, 224, 179),
                  ),
                  child: ListTile(
                    title: Text("BDT ${widget.price} Tk"),
                    subtitle: Text("Negotiable | T&C will be applicable"),
                    trailing: Column(
                      children: [
                        Text("Code"),
                        Text("PS-99"),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                    width: double.infinity,
                    height: 300,
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Brand: "),
                                    Text(widget.brandName.toString()),
                                  ],
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text("Engine : "),
                                      Text(widget.detailsEngine.toString()),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text("Condition : "),
                                      Text(widget.detailsCondition.toString()),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Mileage :",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        widget.detailsMillege.toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Transmission : ",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Expanded(
                                          child: Text(
                                              widget.detailsTransmission
                                                  .toString(),
                                              style: TextStyle(fontSize: 14))),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text("Model :"),
                                      Text(" API?"),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text("Color :"),
                                      Text("API?"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Trim & Edition :",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text("API?"),
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text("Fuel: "),
                                        Text(widget.detailsFuel.toString()),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Skeleton : ",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(widget.skeleton.toString()),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text("Registration: "),
                                        Text(widget.registration.toString()),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text("Grade : "),
                                        Text(widget.detailsGrade.toString()?? '-'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

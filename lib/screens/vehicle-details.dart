import 'package:flutter/material.dart';

class VehicleDetails extends StatefulWidget {
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
      this.vehicleName});

  @override
  State<VehicleDetails> createState() => _VehicleDetailsState();
}

class _VehicleDetailsState extends State<VehicleDetails> {
  @override
  Widget build(BuildContext context) {
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
                        child: Image.network(widget.detailsVehicleImageName.toString()?? ""))),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 90,
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
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    trailing: Column(
                      children: [
                        Text("Code",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),),
                        Expanded(child: Text("PS-99",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
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
                                    Text("Brand : ",style: Theme.of(context).textTheme.titleMedium,),
                                    Text(widget.brandName.toString(),style: Theme.of(context).textTheme.titleMedium),
                                  ],
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text("Engine : ",style: Theme.of(context).textTheme.titleMedium),
                                      Text(widget.engine.toString(),style: Theme.of(context).textTheme.titleMedium),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text("Condition : ",style: Theme.of(context).textTheme.titleMedium),
                                      Text(widget.detailsCondition.toString(),style: Theme.of(context).textTheme.titleMedium),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Mileage :",
                                       style: Theme.of(context).textTheme.titleMedium
                                      ),
                                      Text(
                                        widget.detailsMillege.toString(),style: Theme.of(context).textTheme.titleMedium
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Transmission : ",style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 17)
                                      ),
                                      Expanded(
                                          child: Text(
                                              widget.detailsTransmission
                                                  .toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 17))),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text("Model :",style: Theme.of(context).textTheme.titleMedium),
                                      Text(" API?",style: Theme.of(context).textTheme.titleMedium),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text("Color :",style: Theme.of(context).textTheme.titleMedium),
                                      Text("API?",style: Theme.of(context).textTheme.titleMedium),
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
                                mainAxisSize: MainAxisSize.min,
                              
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Trim & Edition :",style: Theme.of(context).textTheme.titleMedium
                                      ),
                                      Text("API?",style: Theme.of(context).textTheme.titleMedium),
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text("Fuel: ",style: Theme.of(context).textTheme.titleMedium),
                                        Text(widget.detailsFuel.toString(),style: Theme.of(context).textTheme.titleMedium),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Skeleton : ",style: Theme.of(context).textTheme.titleMedium
                                        ),
                                        Text(widget.skeleton.toString(),style: Theme.of(context).textTheme.titleMedium),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text("Registration: ",style: Theme.of(context).textTheme.titleMedium),
                                        Text(widget.registration.toString(),style: Theme.of(context).textTheme.titleMedium),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text("Grade : ",style: Theme.of(context).textTheme.titleMedium),
                                        Text(widget.detailsGrade.toString() ??
                                            '-',style: Theme.of(context).textTheme.titleMedium),
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

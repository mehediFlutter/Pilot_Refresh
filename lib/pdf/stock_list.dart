import 'package:flutter/material.dart';
import 'package:pilot_refresh/pdf/stock_list_item.dart';

class StockList extends StatefulWidget {
  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  @override
  List stockKeyList = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    stockKeyList = [
      'SL',
      'Vehicle Name',
      'Edition',
      'Condition',
      'Engine',
      'Fuel',
      'Skeleton',
      'Mileage',
    ];

    setState(() {});
  }

  @override
  TextStyle stockText = TextStyle();
  bool isIdAdded = false;
  bool isVehicleName = false;
  bool isBrandName = false;
  bool isModel = false;
  bool isRegistration = false;
  bool isEngineNumber = false;
  bool isChassisNumber = false;

  bool isCondition = false;
  bool isEngine = false;
  bool isFuel = false;
  bool isSkeleton = false;
  bool isMileage = false;
  bool isFixedPrice = false;
  bool isAskingPrice = false;
  bool isDetailsLink = false;

  //    isVehicleName= !isVehicleName;
  // isBrandName = !isBrandName;
  // isEngineNumber !=isEngineNumber;
  // isChassisNumber !=isChassisNumber;
  // isEdition !=isEdition;
  // isCondition !=isCondition;
  // isEngine != isEngine;
  // isCondition != isCondition;
  // isEngine != isEngine;
  // isFuel != isFuel;
  // isSkeleton !=isSkeleton;
  // isMileage !=isMileage;
  // isFixedPrice !=isFixedPrice;
  // isAskingPrice !=isAskingPrice;
  // isDetailsLink != isDetailsLink;

  idBoolUpdate() {
    isIdAdded = !isIdAdded;

    //  isIdAddedVision = !isIdAddedVision;
    setState(() {});
    if (isIdAdded == true) {
      stockKeyList.add('ID');

      setState(() {});
    } else {
      stockKeyList.remove('ID');

      setState(() {});
    }
  }

  engineNumberBoolUpdate() {
    isEngineNumber = !isEngineNumber;
    setState(() {});
    if (isEngineNumber == true) {
      stockKeyList.add('Engine Number');

      setState(() {});
    } else {
      stockKeyList.remove('Engine Number');

      setState(() {});
    }
  }

  chasesNumberBoolUpdate() {
    isChassisNumber = !isChassisNumber;
    setState(() {});
    if (isChassisNumber == true) {
      stockKeyList.add('Chassis Number');

      setState(() {});
    } else {
      stockKeyList.remove('Chassis Number');

      setState(() {});
    }
  }

  fixedPriceBoolUpdate() {
    isFixedPrice = !isFixedPrice;
    setState(() {});
    if (isFixedPrice == true) {
      stockKeyList.add('Fixed Price');

      setState(() {});
    } else {
      stockKeyList.remove('Fixed Price');

      setState(() {});
    }
  }

  vechicleNameBoolUpdate() {
    isVehicleName = !isVehicleName;
    setState(() {});
    if (isVehicleName == true) {
      stockKeyList.add('Vehicle Name');

      setState(() {});
    } else {
      stockKeyList.remove('Vehicle Name');

      setState(() {});
    }
  }

  brandNameBoolUpdate() {
    isBrandName = !isBrandName;
    setState(() {});
    if (isBrandName == true) {
      stockKeyList.add('Brand');

      setState(() {});
    } else {
      stockKeyList.remove('Brand');

      setState(() {});
    }
  }

  modelBoolUpdate() {
    isModel = !isModel;
    setState(() {});
    if (isModel == true) {
      stockKeyList.add('Model');

      setState(() {});
    } else {
      stockKeyList.remove('Model');

      setState(() {});
    }
  }

  registrationBoolUpdate() {
    isRegistration = !isRegistration;
    setState(() {});
    if (isRegistration == true) {
      stockKeyList.add('Registration');

      setState(() {});
    } else {
      stockKeyList.remove('Registration');

      setState(() {});
    }
  }

    bool isEdition = false;

  editionBoolUpdate() {
    isEdition = !isEdition;
    setState(() {});
    if (isEdition == true) {
      stockKeyList.add('Edition');

      setState(() {});
    } else {
      stockKeyList.remove('Edition');

      setState(() {});
    }
  }

void toggleStockKey(bool booly, String key, Function(bool) updateFunction) {
  print(booly);
  setState(() {
    if (booly) {
      stockKeyList.add(key);
    } else {
      stockKeyList.remove(key);
    }
    updateFunction(!booly); // Update the boolean value
  });
}

TextButton pdfTextButton(bool booly, String name, String addedName, Function(bool) updateFunction) {
  return TextButton(
    onPressed: () {
      toggleStockKey(booly, name, updateFunction);
    },
    child: booly
        ? Text(
            name,
            style: TextStyle(color: Colors.white),
          )
        : Text(
            addedName,
            style: TextStyle(color: Colors.green),
          ),
          
          
  );

  
}




  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF313131),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
            ),
            Wrap(
              children: [
               pdfTextButton(isEdition, 'Edition', 'Edition Added', (value) {
                setState(() {
                  isEdition = value;
                });
              }),


                TextButton(
                    onPressed: () {
                      idBoolUpdate();
                    },
                    child: isIdAdded
                        ? Text(
                            "Id Added",
                            style: TextStyle(color: Colors.green),
                          )
                        : Text(
                            "Add Id",
                            style: TextStyle(color: Colors.white),
                          )),
                TextButton(
                    onPressed: () {
                      engineNumberBoolUpdate();
                    },
                    child: isEngineNumber
                        ? Text(
                            "Engine Number Added",
                            style: TextStyle(color: Colors.green),
                          )
                        : Text("Engine Number",
                            style: TextStyle(color: Colors.white))),
                TextButton(
                    onPressed: () {
                      chasesNumberBoolUpdate();
                    },
                    child: isChassisNumber
                        ? Text(
                            "Chassis Number Added",
                            style: TextStyle(color: Colors.green),
                          )
                        : Text("Chassis Number",
                            style: TextStyle(color: Colors.white))),
                TextButton(
                    onPressed: () {
                      vechicleNameBoolUpdate();
                    },
                    child: isVehicleName
                        ? Text(
                            "Vehicle Name Added",
                            style: TextStyle(color: Colors.green),
                          )
                        : Text("Vehicle Name",
                            style: TextStyle(color: Colors.white))),
                TextButton(
                    onPressed: () {
                      brandNameBoolUpdate();
                    },
                    child: isBrandName
                        ? Text(
                            "Brand  Added",
                            style: TextStyle(color: Colors.green),
                          )
                        : Text("Brand ",
                            style: TextStyle(color: Colors.white))),
                TextButton(
                    onPressed: () {
                      modelBoolUpdate();
                    },
                    child: isModel
                        ? Text(
                            "Model Added",
                            style: TextStyle(color: Colors.green),
                          )
                        : Text("Model ",
                            style: TextStyle(color: Colors.white))),

                // TextButton(
                //     onPressed: () {
                //       fixedPriceBoolUpdate();
                //     },
                //     child: isFixedPrice
                //         ? Text(
                //             " Fixed Price Added",
                //             style: TextStyle(color: Colors.green),
                //           )
                //         : Text("Fixed Price",
                //             style: TextStyle(color: Colors.white))),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  final pdfFile = await StockListItem.generateCenteredText(
                    addId: isIdAdded,
                    engineNumberbool: isEngineNumber,
                    chasisNumberbool: isChassisNumber,
                    vehicleNamebool: isVehicleName,
                    brandNamebool: isBrandName,
                    modelNamebool: isModel,
                    registratinbool: isRegistration,
                  );
                  StockListItem.openFile(pdfFile);
                },
                child: Text(
                  "Generate PDF your Stock List",
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                )),
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Wrap(
                  spacing: 5.0, // Adjust spacing as needed
                  runSpacing: 0, // Adjust run spacing as needed
                  children: List.generate(
                    stockKeyList.length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          stockKeyList[index],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

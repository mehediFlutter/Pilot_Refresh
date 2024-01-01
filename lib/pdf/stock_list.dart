import 'package:flutter/material.dart';
import 'package:pilot_refresh/pdf/stock_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StockList extends StatefulWidget {
  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  @override
  late bool myBoolValue;
  late SharedPreferences prefs;
  List stockKeyList = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSavedValues();
  }

  Future<void> loadSavedValues() async {
    prefs = await SharedPreferences.getInstance();
    isBrandName = prefs.getBool('isBrandName') ?? true;
    isVehicleName = prefs.getBool('isVehicleName') ?? true;
    isModel = prefs.getBool('isModel') ?? true;
    isEdition = prefs.getBool('isEdition') ?? true;
    isManufacture = prefs.getBool('isManufacture') ?? true;
    isRegistration = prefs.getBool('isRegistration') ?? true;
    isCondition = prefs.getBool('isCondition') ?? false;

    isDetails = prefs.getBool('isDetails') ?? true;
    isFuel = prefs.getBool('isFuel') ?? true;
    isMileage = prefs.getBool('isMileage') ?? true;
    isGrade = prefs.getBool('isGrade') ?? true;
    isPower = prefs.getBool('isPower') ?? false;
    isEngineNumber = prefs.getBool('isEngineNumber') ?? false;
    isChassisNumber = prefs.getBool('isChassisNumber') ?? true;
    isAvailable = prefs.getBool('isAvailable') ?? true;
    isSkeleton = prefs.getBool('isSkeleton') ?? false;
    isTitle = prefs.getBool('isTitle') ?? false;
    isAskingPrice = prefs.getBool('isAskingPrice') ?? true;
    isFixedPrice = prefs.getBool('isFixedPrice') ?? false;

    if (isBrandName) {
      stockKeyList.add('Brand');
    }
    if (isVehicleName) {
      stockKeyList.add('Vehicle Name');
    }
    if (isModel) {
      stockKeyList.add('Model');
    }
    setState(() {});
  }

  Future<void> saveBoolValue(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  @override
  bool isBrandName = false;
  bool isModel = false;
  bool isRegistration = false;
  bool isEngineNumber = false;
  bool isChassisNumber = false;
  bool isEdition = false;
  bool isManufacture = false;
  bool isCondition = false;
  bool isDetails = false;
  bool isEngine = false;
  bool isFuel = false;
  bool isSkeleton = false;
  bool isMileage = false;
  bool isGrade = false;
  bool isPower = false;
  bool isAvailable = false;
  bool isTitle = false;
  bool isFixedPrice = false;
  bool isAskingPrice = false;
  bool isDetailsLink = false;
  bool isIdAdded = false;
  bool isVehicleName = false;

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

  bool pdfInProgress = false;
  engineNumberBoolUpdate() {
    pdfInProgress = true;
    if (mounted) {
      setState(() {});
    }
    isEngineNumber = !isEngineNumber;
    setState(() {});
    if (isEngineNumber == true) {
      stockKeyList.add('Engine Number');
    } else {
      stockKeyList.remove('Engine Number');
    }
    saveBoolValue('isEngineNumber', isEngineNumber);
      pdfInProgress = false;
    if (mounted) {
      setState(() {});
    }
    setState(() {});
  }

  chasesNumberBoolUpdate() {
      pdfInProgress = true;
    if (mounted) {
      setState(() {});
    }
    isChassisNumber = !isChassisNumber;
    setState(() {});
    if (isChassisNumber == true) {
      stockKeyList.add('Chassis Number');

      setState(() {});
    } else {
      stockKeyList.remove('Chassis Number');

      setState(() {});
    }
    saveBoolValue('isChassisNumber', isChassisNumber);
      pdfInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  fixedPriceBoolUpdate() {
      pdfInProgress = true;
    if (mounted) {
      setState(() {});
    }
    isFixedPrice = !isFixedPrice;
    setState(() {});
    if (isFixedPrice == true) {
      stockKeyList.add('Fixed Price');

      setState(() {});
    } else {
      stockKeyList.remove('Fixed Price');

      setState(() {});
    }
    saveBoolValue('isFixedPrice', isFixedPrice);
      pdfInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  vechicleNameBoolUpdate() {
    isVehicleName = !isVehicleName;
    setState(() {});
    if (isVehicleName == true) {
      stockKeyList.add('Vehicle Name');
    } else {
      stockKeyList.remove('Vehicle Name');
    }
    saveBoolValue('isVehicleName', isVehicleName);
    setState(() {});
  }

  brandNameBoolUpdate() {
    isBrandName = !isBrandName;
    setState(() {});
    if (isBrandName == true) {
      stockKeyList.add('Brand');
    } else {
      stockKeyList.remove('Brand');
    }
    saveBoolValue('isBrandName', isBrandName);
    setState(() {});
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
    saveBoolValue('isModel', isModel);
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
    saveBoolValue('isRegistration', isRegistration);
  }

  fuelBoolUpdate() {
    isFuel = !isFuel;
    setState(() {});
    if (isFuel == true) {
      stockKeyList.add('Fuel');

      setState(() {});
    } else {
      stockKeyList.remove('Fuel');

      setState(() {});
    }
    saveBoolValue('isFuel', isFuel);
  }

  mileageBoolUpdate() {
    isMileage = !isMileage;
    setState(() {});
    if (isMileage == true) {
      stockKeyList.add('Mileage');

      setState(() {});
    } else {
      stockKeyList.remove('Mileage');

      setState(() {});
    }
    saveBoolValue('isMileage', isMileage);
  }

  gredeBoolUpdate() {
    isGrade = !isGrade;
    setState(() {});
    if (isGrade == true) {
      stockKeyList.add('Grade');

      setState(() {});
    } else {
      stockKeyList.remove('Grade');

      setState(() {});
    }
    saveBoolValue('isGrade', isGrade);
  }

  powerBoolUpdate() {
    isPower = !isPower;
    setState(() {});
    if (isPower == true) {
      stockKeyList.add('Power');

      setState(() {});
    } else {
      stockKeyList.remove('Power');

      setState(() {});
    }
    saveBoolValue('isPower', isPower);
  }

  availavleBoolUpdate() {
    isAvailable = !isAvailable;
    setState(() {});
    if (isPower == true) {
      stockKeyList.add('Available');

      setState(() {});
    } else {
      stockKeyList.remove('Available');

      setState(() {});
    }
    saveBoolValue('isAvailable', isAvailable);
  }

  skeletonBoolUpdate() {
    isSkeleton = !isSkeleton;
    setState(() {});
    if (isSkeleton == true) {
      stockKeyList.add('Skeleton');

      setState(() {});
    } else {
      stockKeyList.remove('Skeleton');

      setState(() {});
    }
    saveBoolValue('isSkeleton', isSkeleton);
  }

  titleBoolUpdate() {
    isTitle = !isTitle;
    setState(() {});
    if (isTitle == true) {
      stockKeyList.add('Title');

      setState(() {});
    } else {
      stockKeyList.remove('Title');

      setState(() {});
    }
    saveBoolValue('isTitle', isTitle);
  }

  askingPriceBoolUpdate() {
    isAskingPrice = !isAskingPrice;
    setState(() {});
    if (isAskingPrice == true) {
      stockKeyList.add('Asking Price');

      setState(() {});
    } else {
      stockKeyList.remove('Asking Price');

      setState(() {});
    }
    saveBoolValue('isAskingPrice', isAskingPrice);
  }

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
    saveBoolValue('isEdition', isEdition);
  }

  manufactureBoolUpdate() {
    isManufacture = !isManufacture;
    setState(() {});
    if (isManufacture == true) {
      stockKeyList.add('Manufacture');

      setState(() {});
    } else {
      stockKeyList.remove('Manufacture');

      setState(() {});
    }
    saveBoolValue('isManufacture', isManufacture);
  }

  conditionBoolUpdate() {
    isCondition = !isCondition;
    setState(() {});
    if (isCondition == true) {
      stockKeyList.add('Condition');

      setState(() {});
    } else {
      stockKeyList.remove('Condition');

      setState(() {});
    }
    saveBoolValue('isCondition', isCondition);
  }

  detailsBoolUpdate() {
    isDetails = !isDetails;
    setState(() {});
    if (isDetails == true) {
      stockKeyList.add('Details');

      setState(() {});
    } else {
      stockKeyList.remove('Details');

      setState(() {});
    }
    saveBoolValue('isDetails', isDetails);
  }

  ButtonStyle getButtonStyle(bool isTrue) {
    return OutlinedButton.styleFrom(
      fixedSize: Size.fromWidth(150.0), // Set the width as per your requirement
      side: BorderSide(
        color: isTrue ? Colors.green : Colors.white,
      ),
    );
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

  TextButton pdfTextButton(
      Function updateFunction, bool booly, String name, String addedName) {
    return TextButton(
      onPressed: () {
        updateFunction();
      },
      child: booly
          ? Text(
              addedName,
              style: TextStyle(color: Colors.white),
            )
          : Text(
              name,
              style: TextStyle(color: Colors.green),
            ),
    );
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF313131),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                
                Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              vechicleNameBoolUpdate();
                            },
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size.fromWidth(
                                  150.0), // Set the width as per your requirement
                              side: BorderSide(
                                color: isVehicleName ? Colors.green : Colors.white,
                              ),
                            ),
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  color:
                                      isVehicleName ? Colors.green : Colors.white),
                            )),
                        OutlinedButton(
                          onPressed: () {
                            brandNameBoolUpdate();
                          },
                          style: OutlinedButton.styleFrom(
                            fixedSize: Size.fromWidth(
                                150.0), // Set the width as per your requirement
                            side: BorderSide(
                              color: isBrandName ? Colors.green : Colors.white,
                            ),
                          ),
                          child: Text(
                            "Brand ",
                            style: TextStyle(
                                color: isBrandName ? Colors.green : Colors.white),
                          ),
                        ),
                      ],
                    ),
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              modelBoolUpdate();
                            },
                            style: getButtonStyle(isModel),
                            child: Text(
                              "Model",
                              style: TextStyle(
                                  color: isModel ? Colors.green : Colors.white),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              editionBoolUpdate();
                            },
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size.fromWidth(
                                  150.0), // Set the width as per your requirement
                              side: BorderSide(
                                color: isEdition ? Colors.green : Colors.white,
                              ),
                            ),
                            child: Text(
                              "Edition",
                              style: TextStyle(
                                  color: isEdition ? Colors.green : Colors.white),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              manufactureBoolUpdate();
                            },
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size.fromWidth(
                                  150.0), // Set the width as per your requirement
                              side: BorderSide(
                                color: isManufacture ? Colors.green : Colors.white,
                              ),
                            ),
                            child: Text(
                              "Manufacture",
                              style: TextStyle(
                                  color:
                                      isManufacture ? Colors.green : Colors.white),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              registrationBoolUpdate();
                            },
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size.fromWidth(
                                  150.0), // Set the width as per your requirement
                              side: BorderSide(
                                color: isRegistration ? Colors.green : Colors.white,
                              ),
                            ),
                            child: Text(
                              "Registration",
                              style: TextStyle(
                                  color:
                                      isRegistration ? Colors.green : Colors.white),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              conditionBoolUpdate();
                            },
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size.fromWidth(
                                  150.0), // Set the width as per your requirement
                              side: BorderSide(
                                color: isCondition ? Colors.green : Colors.white,
                              ),
                            ),
                            child: Text(
                              "Condition",
                              style: TextStyle(
                                  color: isCondition ? Colors.green : Colors.white),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              detailsBoolUpdate();
                            },
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size.fromWidth(
                                  150.0), // Set the width as per your requirement
                              side: BorderSide(
                                color: isDetails ? Colors.green : Colors.white,
                              ),
                            ),
                            child: Text(
                              "Details",
                              style: TextStyle(
                                  color: isDetails ? Colors.green : Colors.white),
                            )),
                      ],
                    ),
                    // from here use bottom style methode
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              fuelBoolUpdate();
                            },
                            style: getButtonStyle(isFuel),
                            child: Text(
                              "Fuel",
                              style: TextStyle(
                                  color: isFuel ? Colors.green : Colors.white),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              mileageBoolUpdate();
                            },
                            style: getButtonStyle(isMileage),
                            child: Text(
                              "Mileage",
                              style: TextStyle(
                                  color: isMileage ? Colors.green : Colors.white),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              gredeBoolUpdate();
                            },
                            style: getButtonStyle(isGrade),
                            child: Text(
                              "Grade",
                              style: TextStyle(
                                  color: isGrade ? Colors.green : Colors.white),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              powerBoolUpdate();
                            },
                            style: getButtonStyle(isPower),
                            child: Text(
                              "Power",
                              style: TextStyle(
                                  color: isPower ? Colors.green : Colors.white),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              engineNumberBoolUpdate();
                            },
                            style: getButtonStyle(isEngineNumber),
                            child: Text(
                              "Engine Number",
                              style: TextStyle(
                                  color:
                                      isEngineNumber ? Colors.green : Colors.white),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              chasesNumberBoolUpdate();
                            },
                            style: getButtonStyle(isChassisNumber),
                            child: Text(
                              "Chassis Number",
                              style: TextStyle(
                                  color:
                                      isChassisNumber ? Colors.green : Colors.white,
                                  fontSize: 13),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              availavleBoolUpdate();
                            },
                            style: getButtonStyle(isAvailable),
                            child: Text(
                              "Availabel",
                              style: TextStyle(
                                  color: isAvailable ? Colors.green : Colors.white),
                            )),
                        OutlinedButton(
                            onPressed: () {
                              skeletonBoolUpdate();
                            },
                            style: getButtonStyle(isSkeleton),
                            child: Text(
                              "Skeleton",
                              style: TextStyle(
                                  color: isSkeleton ? Colors.green : Colors.white),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: OutlinedButton(
                          onPressed: () {
                            titleBoolUpdate();
                          },
                          style: getButtonStyle(isTitle),
                          child: Text(
                            "Title",
                            style: TextStyle(
                                color: isTitle ? Colors.green : Colors.white),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                                   
                          OutlinedButton(
                              onPressed: () {
                                fixedPriceBoolUpdate();
                              },
                              style: getButtonStyle(isFixedPrice),
                              child: Text(
                                "Fixed Price",
                                style: TextStyle(
                                    color: isFixedPrice ? Colors.green : Colors.white),
                              )),
                               OutlinedButton(
                                  onPressed: () {
                                    askingPriceBoolUpdate();
                                  },
                                  style: getButtonStyle(isAskingPrice),
                                  child: Text(
                                    "Aslking Price",
                                    style: TextStyle(
                                        color:
                                            isAskingPrice ? Colors.green : Colors.white),
                                  )),
                        ],
                      ),
                    ),
                 
                 
                 
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () async {
                        final pdfFile = await StockListItem.generateCenteredText(
                          addId: isIdAdded,
                          engineNumberbool: isEngineNumber,
                          chasisNumberbool: isChassisNumber,
                          vehicleNamebool: isVehicleName,
                          brandNamebool: isBrandName,
                          modelNamebool: isModel,
                          registratinbool: isRegistration,
                          editionbool: isEdition,
                          manufacture: isManufacture,
                          conditionbool: isCondition,
                          detailsbool: isDetails,
                          fuelbool: isFuel,
                          mileagebool: isMileage,
                          gradebool: isGrade,
                          powerBool: isPower,
                          availavleBool: isAvailable,
                          skeletonBool: isSkeleton,
                          titleBool: isTitle,
                          askingPriceBool: isAskingPrice,
                          fixedPriceBool: isFixedPrice,
                        );
                        StockListItem.openFile(pdfFile);
                      },
                      // style: ElevatedButton.styleFrom(
                      //   backgroundColor: Colors.white
                      // ),
                      child: Text(
                        "Generate PDF Stock List",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'If you want to remove stock list item  you can click the green items',
                  style: TextStyle(fontSize: 12),
                ),
                // Expanded(
                //   child: Container(
                //     alignment: Alignment.bottomLeft,
                //     child: Wrap(
                //       spacing: 5.0, // Adjust spacing as needed
                //       runSpacing: 0, // Adjust run spacing as needed
                //       children: List.generate(
                //         stockKeyList.length,
                //         (index) {
                //           return Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Text(
                //               stockKeyList[index],
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

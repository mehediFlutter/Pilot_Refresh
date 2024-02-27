import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pilot_refresh/const_color/border_color_radious.dart';
import 'package:pilot_refresh/const_color/constant_color.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:intl/intl.dart'; // Import the intl package

class CalculateCarPrice extends StatefulWidget {
  const CalculateCarPrice({super.key});

  @override
  State<CalculateCarPrice> createState() => _CalculateCarPriceState();
}

class _CalculateCarPriceState extends State<CalculateCarPrice> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  TextEditingController texController = TextEditingController();
  TextEditingController dollerRateController = TextEditingController();
  TextEditingController howManyDollerController = TextEditingController();
  TextEditingController perDayChargeController = TextEditingController();
  TextEditingController otherCostController = TextEditingController();
  TextEditingController perDayCostController = TextEditingController();
  TextEditingController howManyDaysController = TextEditingController();
  @override
  final largeRound = BorderRadius.circular(22);
  final borderGrey = BorderSide(color: Colors.grey);
  final borderBlack = BorderSide(color: Colors.black);
  final F5BorderColor = Border.all(color: Color(0xFFF5F5F5));
  final textFildContentPadding =
      EdgeInsets.symmetric(horizontal: 15, vertical: 20);

  final customFocusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.white),
  );
  final customEnableBOrder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey),
  );

  TextStyle labelTextStyle =
      TextStyle(color: Colors.grey, fontSize: 15, fontFamily: 'Roboto');
  TextStyle keyAndValueStyle =
      TextStyle(fontSize: 15, color: Colors.black87, fontFamily: 'Axiforma');

  // TextStyle textFileStyle =  Theme.of(context)
  //                   .textTheme
  //                   .bodyMedium!
  //                   .copyWith(color: Colors.white),

  double? tax, perDayCost = 0, otherCost;
  double? dollerRate, dayCostResult, dollerCostResult;
  int howManyDays = 0, howManyDollers = 0;
  double? totalResult, totalResultIntoDoller = 0;
  String amountInWords = '';
  double totalTake = 000;

  calculate() async {
    perDayCost = double.tryParse(perDayChargeController.text) ?? 0;
    howManyDays = int.tryParse(howManyDaysController.text) ?? 0;
    setState(() {});
    dayCostResult = perDayCost! * howManyDays;
    setState(() {});

    tax = double.tryParse(texController.text) ?? 0;
    setState(() {});
    howManyDollers = int.tryParse(howManyDollerController.text) ?? 0;
    dollerRate = double.tryParse(dollerRateController.text) ?? 0;
    setState(() {});
    dollerCostResult = howManyDollers * dollerRate!;
    otherCost = double.tryParse(otherCostController.text) ?? 0;

    setState(() {});
    totalResult = dayCostResult! + dollerCostResult! + tax! + otherCost!;
  }

  bool isDoller = true;
  convertIntoDoller() async {
    //   totalResultIntoDoller = totalResult! / dollerRate!;
    isDoller = !isDoller;
//    totalResultIntoDoller = totalResult! / dollerRate!;
    setState(() {});
  }

  totalResultInDoller() {
    totalResultIntoDoller = totalResult! / dollerRate!;
    setState(() {});
  }

  priceAlartDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return SizedBox(
              width: double.infinity,
              child: AlertDialog(
                elevation: 5,
                shadowColor: const Color.fromARGB(255, 58, 55, 55),
                backgroundColor: const Color.fromARGB(255, 185, 180, 180),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                titlePadding: EdgeInsets.only(top: 40, bottom: 20),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ' Here is Your Car Price ',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Axiforma'),
                    ),
                  ],
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Tax',
                          style: keyAndValueStyle,
                        ),
                        Spacer(),
                        Text(
                          tax.toString() + ' Tk',
                          style: keyAndValueStyle,
                        ),
                      ],
                    ),
                    largeHeightGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Per Day Cost (Rent)',
                          style: keyAndValueStyle,
                        ),
                        Spacer(),
                        Text(
                          perDayCost.toString() + ' Tk',
                          style: keyAndValueStyle,
                        ),
                      ],
                    ),
                    largeHeightGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Days(Rents) ',
                          style: keyAndValueStyle,
                        ),
                        Spacer(),
                        Text(
                          howManyDays.toString() + ' Days',
                          style: keyAndValueStyle,
                        ),
                      ],
                    ),
                    largeHeightGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Doller',
                          style: keyAndValueStyle,
                        ),
                        Spacer(),
                        Text(
                          howManyDollers.toString() + ' Dollers',
                          style: keyAndValueStyle,
                        ),
                      ],
                    ),
                    largeHeightGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Doller Rate',
                          style: keyAndValueStyle,
                        ),
                        Spacer(),
                        Text(
                          dollerRate.toString() + ' Tk',
                          style: keyAndValueStyle,
                        ),
                      ],
                    ),
                    largeHeightGap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Other Cost',
                          style: keyAndValueStyle,
                        ),
                        Spacer(),
                        Text(
                          otherCost.toString() + ' Tk',
                          style: keyAndValueStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Total Cost',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          isDoller
                              ? '${NumberFormat('#,##0').format(totalResult)} Tk' // Format with commas
                              : '${NumberFormat('#,##0.00').format(totalResultIntoDoller)} \$', // Format with commas and 2 decimal places
                          style: keyAndValueStyle.copyWith(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    '( ${isDoller ? NumberToWordsEnglish.convert(totalResult!.toInt()) : NumberToWordsEnglish.convert(totalResultIntoDoller!.toInt())} )',
                                    style:
                                        keyAndValueStyle.copyWith(fontSize: 10),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () async {
                            totalResultInDoller();
                            convertIntoDoller();
                            setState(() {});
                            print(dollerCostResult);
                          },
                          child: Text(
                            isDoller
                                ? 'Convert into Doller'
                                : 'Convert into Taka',
                            style:
                                keyAndValueStyle.copyWith(color: Colors.blue),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        isDoller = true;
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Text(
                        ('Close'),
                        style: keyAndValueStyle,
                      ))
                ],
              ),
            );
          });
        });
  }

  carPriceSingleRow(String key, double value) {
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          key,
          style: keyAndValueStyle,
        ),
        Spacer(),
        Text(
          value.toString() + 'Tk',
          style: keyAndValueStyle,
        ),
      ],
    );
  }

  Future getMethodes() async {
    await calculate();
    await priceAlartDialog(context);
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height / 12),
                  Center(
                      child: Text(
                    "Calculate Your Car Current Price",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                  SizedBox(height: size.height / 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                    cursorColor: Colors.white,
                    cursorHeight: 20,
                    controller: texController,
                    decoration: InputDecoration(
                        labelText: 'Enter Tax',
                        labelStyle: labelTextStyle,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red))),
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter mobile number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: perDayChargeController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: 'Per day Cost',
                      labelStyle: labelTextStyle,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter Par Day cost';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: howManyDaysController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: 'How Many Days',
                      labelStyle: labelTextStyle,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter Days';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: howManyDollerController,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                    cursorColor: Colors.white,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      labelText: 'How Many Doller',
                      labelStyle: labelTextStyle,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    //   validator: (value) {
                    //   if(value?.isEmpty??true){
                    //     return 'Enter Doller Amount';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(height: 20),
            TextFormField(
                    keyboardType: TextInputType.number,
                    controller: dollerRateController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    cursorColor: Colors.white,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      labelText: 'Enter Doller Rate',
                      labelStyle: labelTextStyle,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (howManyDollerController.text.isNotEmpty)
                        ? (value) {
                            if (value!.isEmpty) {
                              return 'Doller Rate is required';
                            }
                            // You can add more validation logic here if needed
                            return null;
                          }
                        : null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (String? value) {
                      if (value?.isEmpty ?? true) {
                        return 'Enter Tax';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                    controller: otherCostController,
                    cursorColor: Colors.white,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                        labelText: 'Other Cost',
                        labelStyle: labelTextStyle,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white))),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (!_globalKey.currentState!.validate()) {
                              return null;
                            }
                            await calculate();
                            await priceAlartDialog(context);
                            //     getMethodes();
                          },
                          child: Text(
                            "Calculate Price",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ))),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

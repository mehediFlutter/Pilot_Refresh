import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:pilot_refresh/unic_title_and_details_function_class.dart';

class AlartDialogClass extends StatefulWidget {
  final int id;
  final String vehicleName;
  const AlartDialogClass({super.key, required this.id, required this.vehicleName});

  @override
  State<AlartDialogClass> createState() => _AlartDialogClassState();
}

class _AlartDialogClassState extends State<AlartDialogClass> {
  List unicTitle = [];
  List details = [];
  void getDetails() async {
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
    setState(() {});

    for (int x = 0; x < unicTitle.length; x++) {
      print(unicTitle[x]);
      print(details[x]);
    }
    //print("Unic title");
    //print(tittt);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: detailsAlartDialog(context)));
  }

  AlertDialog detailsAlartDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF313131),
      contentPadding: EdgeInsets.zero,
      title: Text(
        "Details of ${widget.vehicleName.toString()}",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Expanded(
        child: Container(
          height: 500,
          width: 350,
          child: ListView.separated(
            itemCount: unicTitle.length,
            itemBuilder: (context, index) {
              return Expanded(
                child: ListTile(
                  title: Expanded(
                    child: Row(
                      children: [
                        Expanded(child: Text(unicTitle[index].toString(),style: TextStyle(color: Colors.white),)),
                        Expanded(child: Text(details[index].toString(),style: TextStyle(color: Colors.white),)),
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

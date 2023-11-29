import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pilot_refresh/search/search_details.dart';
import 'package:pilot_refresh/widget/products.dart';

class PilotSearch extends StatefulWidget {
  const PilotSearch({super.key});

  @override
  State<PilotSearch> createState() => _PilotSearchState();
}

class _PilotSearchState extends State<PilotSearch> {
  String searchValue = ''; // Define the search term variable

  static List allproducts = [];
  static List newProducts = [];

  // ... (rest of your existing code)
  void getProduct() async {
    for (int f = 1; f <= 7; f++) {
      Response response =
          await get(Uri.parse("https://pilotbazar.com/api/vehicle?page=$f"));
      //https://pilotbazar.com/api/vehicle?page=0
      //https://crud.teamrabbil.com/api/v1/ReadProduct
      print(response.statusCode);
      final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

      print(decodedResponse['data']);
      for (int i = 0; i < decodedResponse['data'].length; i++) {
        allproducts.add(Product(
          vehicleName:
              decodedResponse['data'][i]['translate'][0]['title'] ?? '',
          manufacture: decodedResponse['data'][i]['manufacture'] ?? '',
          slug: decodedResponse['data'][i]['slug'] ?? '',
          id: decodedResponse['data'][i]['id'] ?? '',
          condition: decodedResponse['data'][i]['condition']['translate'][0]
                  ['title'] ??
              '',
          mileage: decodedResponse['data'][i]['mileage']['translate'][0]
                  ['title'] ??
              '',
          price: decodedResponse['data'][i]['price'] ?? '',
          imageName: decodedResponse['data'][i]['image']['name'] ?? '',
          registration: decodedResponse['data'][i]['registration'] ?? '-',
        ));
      }
      setState(() {
        allproducts;
      });
    }
    //print(allproducts.toString());
  }

  @override
  void initState() {
    super.initState();
    getProduct();
    updateList('');
  }

  void updateList(String val) {
    setState(() {
      searchValue = val; // Update the search term variable

      if (val.isEmpty) {
        newProducts = List.from(allproducts);
      } else {
        List<String> searchTerms = val.toLowerCase().split(' ');

        newProducts = allproducts.where((element) {
          String combinedText =
              '${element.vehicleName} ${element.manufacture}'.toLowerCase();

          // Check if all search terms are present in the combined text
          return searchTerms.every((term) => combinedText.contains(term));
        }).toList();
      }
    });
    print(allproducts.length);
    print(newProducts.length);
  }

  Widget build(BuildContext context) {
    // List<Product> displayProducts =
    //     searchValue.isEmpty ? List.from(allproducts) : List.from(newProducts);

    return Scaffold(
      appBar: AppBar(
        title: Text("Search PilotBazar"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                updateList(value);
              },
              decoration: InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: newProducts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("Tapped the listile");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearachDetailsVehicle(
                            VehicleName: newProducts[index].vehicleName,
                            VehiceId: newProducts[index].id.toString(),
                            imageName: newProducts[index].imageName,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Image.network(
                          "https://pilotbazar.com/storage/vehicles/${newProducts[index].imageName}",
                        ),
                        subtitle: Column(
                          children: [
                            Text(newProducts[index].id.toString()),
                            Text(newProducts[index].vehicleName.toString()),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

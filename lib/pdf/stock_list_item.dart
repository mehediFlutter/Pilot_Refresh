import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';
import 'package:pilot_refresh/product.dart'; // Import PdfColor

class StockListItem extends StatefulWidget {
  final bool addId;
  final bool engineNumberbool;
  final bool chasisNumberbool;
  final bool vehicleNamebool;
  final bool brandNamebool;
  final bool modelNamebool;
  final bool registratinbool;
  final bool editionbool;
  final bool manufacture;
  final bool conditionbool;
  final bool detailsbool;
  final bool fuelbool;
  final bool mileagebool;
  final bool gradebool;
  final bool powerBool;
  final bool availavleBool;
  final bool skeletonBool;
  final bool titleBool;
  final bool askingPriceBool;
  final bool fixedPriceBool;

  StockListItem({
    Key? key,
    this.addId = false,
    this.engineNumberbool = false,
    this.chasisNumberbool = false,
    this.vehicleNamebool = false,
    this.brandNamebool = false,
    this.modelNamebool = false,
    this.registratinbool = false,
    this.editionbool = false,
    this.manufacture = false,
    this.conditionbool = false,
    this.detailsbool = false,
    this.fuelbool = false,
    this.mileagebool = false,
    this.gradebool = false,
    this.powerBool = false,
    this.availavleBool = false,
    this.skeletonBool = false,
    this.titleBool = false,
    this.askingPriceBool = false,
    this.fixedPriceBool = false,
  }) : super(key: key);

  @override
  _StockListItemState createState() => _StockListItemState();

  static Future<File> generateCenteredText({

    bool addId = false,
    bool engineNumberbool = false,
    bool chasisNumberbool = false,
    bool vehicleNamebool = false,
    bool brandNamebool = false,
    bool modelNamebool = false,
    bool registratinbool = false,
    bool editionbool = false,
    bool manufacture = false,
    bool conditionbool = false,
    bool detailsbool = false,
    bool fuelbool = false,
    bool mileagebool = false,
    bool gradebool = false,
    bool powerBool = false,
    bool availavleBool = false,
    bool skeletonBool = false,
    bool titleBool = false,
    bool askingPriceBool = false,
    bool fixedPriceBool = false,
  }) {
    return _StockListItemState()._generateCenteredText(
      addId: addId,
      engineNumberbool: engineNumberbool,
      chasisNumberbool: chasisNumberbool,
      vehicleNamebool: vehicleNamebool,
      brandNamebool: brandNamebool,
      modelNamebool: modelNamebool,
      registratinbool: registratinbool,
      editionbool: editionbool,
      manufacture: manufacture,
      conditionbool: conditionbool,
      detailsbool: detailsbool,
      fuelbool: fuelbool,
      mileagebool: mileagebool,
      gradebool: gradebool,
      powerBool: powerBool,
      availavleBool: availavleBool,
      skeletonBool: skeletonBool,
      titleBool: titleBool,
      askingPriceBool: askingPriceBool,
      fixedPriceBool: fixedPriceBool,
    );
  }

  static Future<void> openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}

class _StockListItemState extends State<StockListItem> {
  @override
  static List products = [];
  bool getAllProductsInProgress = false;

  getProduct() async {


    //  for (int b = 1; b < 11; b++) {
   Response response = await get(Uri.parse(
        "https://pilotbazar.com/api/merchants/vehicles/products/stocklist"));

    print(response.statusCode);
    final Map<String, dynamic> decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      products.clear();
      decodedResponse['payload'].forEach(
        (e) {
          products.add(Product(
            id: e['id'] ?? 0,
            vehicleName: e['translate'][0]?['title'] ?? "--",
            brandName: e['brand']?['translate'][0]?['title'] ?? "--",
            engineNumber: e['engine_number'] ?? '--',
            chassisNumber: e['chassis_number'] ?? '--',
            edition: e['edition']['translate'][0]?['title'] ?? '--',
            condition: e['condition']?['translate'][0]?['title'] ?? '--',
            //code: e['code'] ?? '--',
            engine: e['engine']?['translate'][0]?['title'] ?? '--',
            fuel: e['fuel']?['translate'][0]?['title'] ?? '--',
            skeleton: e['skeleton']?['translate'][0]?['title'] ?? '--',
            mileage: e['mileage']?['translate'][0]?['title'] ?? '--',

            fixed_price: e['fixed_price'] ?? '--',
            model: e['carmodel']?['translate'][0]?['title'] ?? '--',
            manufacture: e['manufacture'] ?? '--',
            registration: e['registration'] ?? '--',
            grade: e['grade']?['translate'][0]?['title'] ?? '--',
            available: e['available']?['translate'][0]?['title'] ?? '--',
            asking_price: e['price'] ?? '--',
          ));
        },
      );
       if (decodedResponse == null) {
        return;
      }
   

    }
   
  }

  
  Future<File> _generateCenteredText({
    bool addId = false,
    bool engineNumberbool = false,
    bool chasisNumberbool = false,
    bool vehicleNamebool = false,
    bool brandNamebool = false,
    bool modelNamebool = false,
    bool registratinbool = false,
    bool editionbool = false,
    bool manufacture = false,
    bool conditionbool = false,
    bool detailsbool = false,
    bool fuelbool = false,
    bool mileagebool = false,
    bool gradebool = false,
    bool powerBool = false,
    bool availavleBool = false,
    bool skeletonBool = false,
    bool titleBool = false,
    bool askingPriceBool = false,
    bool fixedPriceBool = false,
  }) async {
    await getProduct();
        final totalPages = (products.length / 15).ceil();


    final pdf = p.Document();

    for (int currentPage = 1; currentPage <= totalPages; currentPage++) {
     
      pdf.addPage(
        p.Page(
          build: (context) {
            return p.Column(
              crossAxisAlignment: p.CrossAxisAlignment.start,
              children: [
                //  p.Text("Sample Text Pilot Bazar.com ", style: p.TextStyle(fontSize: 30)),
                p.Align(
                    alignment: p.Alignment.bottomRight,
                    child: p.Text("Page $currentPage")),

                _buildProductListView(
                  currentPage,
                    
                  addId,
                
                  engineNumberbool,
                  chasisNumberbool,
                  vehicleNamebool,
                  brandNamebool,
                  modelNamebool,
                  registratinbool,
                  editionbool,
                  manufacture,
                  conditionbool,
                  detailsbool,
                  fuelbool,
                  mileagebool,
                  gradebool,
                  powerBool,
                  availavleBool,
                  skeletonBool,
                  titleBool,
                  askingPriceBool,
                  fixedPriceBool,
                ),
              ],
            );
          },
        ),
      );
   
    }
    return _saveDocument(name: 'Pilot_Bazar_Stock_List.pdf', pdf: pdf);
  }


  titleStock(String title) {
    return p.Padding(
      padding: p.EdgeInsets.all(2),
      child: p.Text(title, style: p.TextStyle(fontSize: 8)),
    );
  }

  p.Widget _buildProductListView(
    int currentPage,
    bool addId,
    bool engineNumberbool,
    bool chasisNumberbool,
    bool vehicleNamebool,
    bool brandNamebool,
    bool modelNamebool,
    bool registratinbool,
    bool editionbool,
    bool manufacturebool,
    bool conditionbool,
    bool detailsbool,
    bool fuelbool,
    bool mileagebool,
    bool gradebool,
    bool powerBool,
    bool availavleBool,
    bool skeletonBool,
    bool titleBool,
    bool askingPriceBool,
    bool fixedPriceBool,
  ) {

print(addId);
    return p.Table(
      border: p.TableBorder.all(
        style: p.BorderStyle.solid,
        color: PdfColor.fromInt(const Color.fromARGB(255, 221, 219, 219).value),
      ),
      defaultVerticalAlignment: p.TableCellVerticalAlignment.middle,
      children: [
        // Table header
        p.TableRow(
          verticalAlignment: p.TableCellVerticalAlignment.middle,
          decoration:
              p.BoxDecoration(color: PdfColor.fromInt(Colors.grey.value)),
          children: [
            titleStock('SL'),
           
            //  if(widget.isIdIsAddedStockList??false)
            if (brandNamebool) titleStock('Brand Name'),
            if (modelNamebool) titleStock('Model'),
            if (editionbool) titleStock('Edition'),
            if (manufacturebool) titleStock('Manufacture'),
            if (registratinbool) titleStock('Registration'),
            if (conditionbool) titleStock('Condition'),
            if (detailsbool) titleStock('Details'),
            if (fuelbool) titleStock('Fuel'),

            if (mileagebool) titleStock('Mileage'),
            if (gradebool) titleStock('Grade'),
            if (powerBool) titleStock('Power'),
            if (engineNumberbool) titleStock('Engine Number'),
            if (chasisNumberbool) titleStock('Chassis Number'),
            if (availavleBool) titleStock('Available'),
            if (skeletonBool) titleStock('Skeleton'),

            if (vehicleNamebool) titleStock('Title'),
            if (askingPriceBool) titleStock('Asking Price'),

            if (fixedPriceBool) titleStock('"Fixed Price"'),

            if (addId) titleStock('ID'),

            // p.Text("Code", style: p.TextStyle(fontSize: 10)),
          ],
        ),
       for (int i = (currentPage - 1) * 15;
            i < currentPage * 15 && i < products.length;
            i++)
            
          p.TableRow(
            verticalAlignment: p.TableCellVerticalAlignment.middle,
            children: [
              p.Padding(
                padding: p.EdgeInsets.only(right: 10, left: 0),
                child: p.Text((products.indexOf(products[i]) + 1).toString(),
                    softWrap: false,
                    style: p.TextStyle(
                      fontSize: 8,
                      color: PdfColor.fromInt(Colors.black87.value),
                    )),
              ),
              //if(widget.isIdIsAddedStockList??false)
              if (brandNamebool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].brandName.toString(),
                      style: p.TextStyle(fontSize: 8), softWrap: false),
                ),
              if (modelNamebool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].model.toString(),
                      style: p.TextStyle(fontSize: 7)),
                ),
              if (editionbool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].edition.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),
              if (manufacturebool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].manufacture.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),

              if (registratinbool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].registration.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),
              if (conditionbool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].condition.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),
              if (detailsbool)
                p.UrlLink(
                  // Use p.UrlLink for clickable links in PDF
                  child: p.Text("Details",
                      style: p.TextStyle(
                        fontSize: 5,
                        color: PdfColor.fromInt(
                            Color.fromARGB(255, 39, 87, 129).value),
                      )),
                  destination: "https://pilotbazar.com", // Adjust URL as needed
                ),
              if (fuelbool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].fuel.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),

              if (mileagebool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].mileage.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),
              if (gradebool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].grade.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),

              if (powerBool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].engine.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),
              if (engineNumberbool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].engineNumber.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),
              if (chasisNumberbool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].chassisNumber.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),
              if (availavleBool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].available.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),
              if (skeletonBool)
                p.Padding(
                  padding: p.EdgeInsets.all(2),
                  child: p.Text(products[i].skeleton.toString(),
                      style: p.TextStyle(fontSize: 8)),
                ),

              if (vehicleNamebool)
                p.Padding(
                  padding: p.EdgeInsets.all(4),
                  child: p.Text(products[i].vehicleName.toString(),
                      style: p.TextStyle(
                        fontSize: 8,
                        color: PdfColor.fromInt(Colors.black87.value),
                      )),
                ),

              // p.Text(products[i].code.toString(), style: p.TextStyle(fontSize: 10)),

              if (askingPriceBool)
                p.Padding(
                  padding: p.EdgeInsets.only(right: 15, left: 1),
                  child: p.Text(products[i].asking_price.toString(),
                      style: p.TextStyle(fontSize: 7), softWrap: false),
                ),
              if (fixedPriceBool)
                p.Padding(
                  padding: p.EdgeInsets.only(right: 15, left: 1),
                  child: p.Text(products[i].fixed_price.toString(),
                      style: p.TextStyle(fontSize: 7), softWrap: false),
                ),

              if (addId)
                p.Padding(
                  padding: p.EdgeInsets.only(right: 12, left: 0),
                  child: p.Text(products[i].id.toString(),
                      style: p.TextStyle(fontSize: 7), softWrap: false),
                ),
            ],
          ),
      ],
    );
  }

  Future<File> _saveDocument({
    required String name,
    required p.Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getExternalStorageDirectory(); // Use external storage

    if (dir == null) {
      throw Exception('External storage not available');
    }

    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);

    return file;
  }

  bool _getProductinProgress = false;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

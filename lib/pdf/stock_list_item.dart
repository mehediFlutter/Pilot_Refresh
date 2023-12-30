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

  StockListItem({Key? key, this.addId = false}) : super(key: key);

  @override
 
  _StockListItemState createState() => _StockListItemState();
   


  static Future<File> generateCenteredText({bool addId = false}) {
    return _StockListItemState()._generateCenteredText(addId:addId);
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
    getAllProductsInProgress = true;
    if (mounted) {
      setState(() {});
    }

    //  for (int b = 1; b < 11; b++) {
    Response response =
        await get(Uri.parse("https://pilotbazar.com/api/merchants/vehicles/products/stocklist"));
    //https://pilotbazar.com/api/vehicle?page=0
    //https://crud.teamrabbil.com/api/v1/ReadProduct
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
            // slug: e['slug'] ?? '',
          ));
        },
      );
      if (decodedResponse == null) {
        return;
      }

      getAllProductsInProgress = false;
      if (mounted) {
        setState(() {});
      }

    }
    getAllProductsInProgress = false;
    if (mounted) {
      setState(() {});
    }
    print("Is Id added Stocklist ");
   
  }




  Future<File> _generateCenteredText({bool  addId = false}) async {
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

                _buildProductListView(currentPage,addId),
              ],
            );
          },
        ),
      );
    }
    return _saveDocument(name: 'my_example.pdf', pdf: pdf);
  }

  p.Widget _buildProductListView(int currentPage,bool addId) {
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
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("SL ", style: p.TextStyle(fontSize: 8,),softWrap: false),
              ),
                //  if(widget.isIdIsAddedStockList??false)
                  
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("Vehicle Name ", style: p.TextStyle(fontSize: 8)),
              ),
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("Brand Name ", style: p.TextStyle(fontSize: 8)),
              ),
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("Engine Number", style: p.TextStyle(fontSize: 8)),
              ),
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("Chassis Number", style: p.TextStyle(fontSize: 8)),
              ),
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("Edition", style: p.TextStyle(fontSize: 8)),
              ),
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("Condition", style: p.TextStyle(fontSize: 8)),
              ),
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("Engine", style: p.TextStyle(fontSize: 8)),
              ),
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("Fuel", style: p.TextStyle(fontSize: 8)),
              ),
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("Skeleton", style: p.TextStyle(fontSize: 8)),
              ),
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("Mileage", style: p.TextStyle(fontSize: 8)),
              ),
                   p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("Fixed Price", style: p.TextStyle(fontSize: 8)),
              ),
             if(addId)  p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text("ID", style: p.TextStyle(fontSize: 8)),
              ),
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
                padding: p.EdgeInsets.only(right: 13,left: 5),
                child: p.Text((products.indexOf(products[i]) + 1).toString(),softWrap: false,
                    style: p.TextStyle(
                      fontSize: 8,
                      color: PdfColor.fromInt(Colors.black87.value),
                    )),
              ),
              //if(widget.isIdIsAddedStockList??false)
              
              p.Padding(
                padding: p.EdgeInsets.all(5),
                child: p.Text(products[i].vehicleName.toString(),
                    style: p.TextStyle(
                      fontSize: 8,
                      color: PdfColor.fromInt(Colors.black87.value),
                    )),
              ),
              p.Padding(
                padding: p.EdgeInsets.all(5),
                child: p.Text(products[i].brandName.toString(),
                    style: p.TextStyle(fontSize: 8), softWrap: false),
              ),
              p.Padding(
                padding: p.EdgeInsets.all(5),
                child: p.Text(products[i].engineNumber.toString(),
                    style: p.TextStyle(fontSize: 8)),
              ),
              p.Padding(
                padding: p.EdgeInsets.all(5),
                child: p.Text(products[i].chassisNumber.toString(),
                    style: p.TextStyle(fontSize: 8)),
              ),
              p.Padding(
                padding: p.EdgeInsets.all(5),
                child: p.Text(products[i].edition.toString(),
                    style: p.TextStyle(fontSize: 8)),
              ),
              p.Padding(
                padding: p.EdgeInsets.all(5),
                child:  p.Text(products[i].condition.toString(),
                    style: p.TextStyle(fontSize: 8)),
              ),
              p.Padding(
                padding: p.EdgeInsets.all(5),
                child:    p.Text(products[i].engine.toString(),
                    style: p.TextStyle(fontSize: 8)),
              ),
              p.Padding(
                padding: p.EdgeInsets.all(5),
                child:    p.Text(products[i].fuel.toString(),
                    style: p.TextStyle(fontSize: 8)),
              ),

              
             
            
              // p.Text(products[i].code.toString(), style: p.TextStyle(fontSize: 10)),
               p.Padding(
                padding: p.EdgeInsets.all(5),
                child:     p.Text(products[i].skeleton.toString(),
                    style: p.TextStyle(fontSize: 8)),
              ),

               p.Padding(
                padding: p.EdgeInsets.all(5),
                child:         p.Text(products[i].mileage.toString(),
                    style: p.TextStyle(fontSize: 8)),
              ),

               p.Padding(
               padding: p.EdgeInsets.only(right: 15,left: 1),
                child:           p.Text(products[i].fixed_price.toString(),
                    style: p.TextStyle(fontSize: 7),softWrap: false),
              ),
            if(addId)
            p.Padding(
               padding: p.EdgeInsets.only(right: 12,left: 0),
                child:           p.Text(products[i].id.toString(),
                    style: p.TextStyle(fontSize: 7),softWrap: false),
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

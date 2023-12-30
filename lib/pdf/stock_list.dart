import 'package:flutter/material.dart';
import 'package:pilot_refresh/pdf/stock_list_item.dart';

class StockList extends StatefulWidget {
  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  @override
    static bool isIdAdded = false;
  bool isIdAddedVision = false;

  updateBool() {
    isIdAdded = !isIdAdded;
    isIdAddedVision = !isIdAddedVision;
    setState(() {});
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             ElevatedButton(
                onPressed: () {
                  updateBool();
                },
                child: isIdAddedVision
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(" your id is add ",style: TextStyle(color: Colors.grey,fontSize: 10),),
                          Text("do you Remove id",style: TextStyle(color: Colors.red,fontSize: 10),)
                        ],
                      )
                    : Text("Add Id")),
                    SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {
                  final pdfFile =
                      await StockListItem.generateCenteredText(addId: isIdAdded);
                  StockListItem.openFile(pdfFile);
                },
                child: Text("PDF")),
           
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:pilot_refresh/pdf/stock_list.dart';
import 'package:pilot_refresh/pdf/stock_list_item.dart';

class AskingFixedAndStockList extends StatefulWidget {
  final Function? askingPriceFunction;
  final Function? fixedPriceFunction;
  final Function? stockListFunction;
  const AskingFixedAndStockList(
      {super.key,
      this.askingPriceFunction,
      this.fixedPriceFunction,
      this.stockListFunction});

  @override
  State<AskingFixedAndStockList> createState() =>
      _AskingFixedAndStockListState();
}

class _AskingFixedAndStockListState extends State<AskingFixedAndStockList> {
  @override
  Color fixedPriceColor = Colors.white;
  Color askingPriceColor = Colors.green;

  Color stockListColor = Colors.white;
  bool _createPdfInProgress = false;
  Future<void> createPdf() async {
    _createPdfInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final pdfFile = await StockListItem.generateCenteredText();
    StockListItem.openFile(pdfFile);
    _createPdfInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

// void changeColor(){
//   setState(() {
//     fixedPriceColor = fixedPriceColor == Colors.green ? Colors.green : Colors.green;
//   });
// }

// void changeAskingPriceColor(){
//   setState(() {
//     askingPriceColor = askingPriceColor == Colors.white ? Colors.green : Colors.white;
//   });
// }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              stockListColor = Colors.white;
              fixedPriceColor = Colors.white;
              askingPriceColor = Colors.green;
              // changeColor();
              widget.askingPriceFunction?.call();
              setState(() {});
            },
            icon: Text(
              "Asking Price",
              style: TextStyle(color: askingPriceColor),
            )),
        IconButton(
            onPressed: () {
              askingPriceColor = Colors.white;

              stockListColor = Colors.white;
              fixedPriceColor = Colors.green;

              widget.fixedPriceFunction?.call();
              setState(() {});
            },
            icon: Text(
              "Fixed Price",
              style: TextStyle(color: fixedPriceColor),
            )),
        IconButton(
            onPressed: () async {
              stockListColor = Colors.green;
              fixedPriceColor = Colors.white;
              askingPriceColor = Colors.white;
              widget.stockListFunction?.call();
              setState(() {});
             Navigator.push(context, MaterialPageRoute(builder: (context)=>StockList()));
            },
            icon: Text(
              "Stock List",
              style: TextStyle(color: stockListColor),
            )),
      ],
    );
  }
}

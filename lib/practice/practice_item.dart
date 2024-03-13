import 'package:flutter/material.dart';

class PracticeItem extends StatefulWidget {
  final bool isAskingPrice;
  final String? vehiclaName;
  final String? price;
  final String? newPrice;

  PracticeItem({
    required this.isAskingPrice,
    this.vehiclaName,
    this.newPrice,
    this.price,
  });

  @override
  _PracticeItemState createState() => _PracticeItemState();
}

class _PracticeItemState extends State<PracticeItem> {
  @override
  void initState() {
    print(widget.price);
    print(widget.newPrice);
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.isAskingPrice ? widget.price.toString() : widget.newPrice.toString(),style: TextStyle(fontSize: 15,color: Colors.white),),
        Text(widget.vehiclaName.toString(),style: TextStyle(fontSize: 15,color: Colors.white)),
      ],
    );
  }
}
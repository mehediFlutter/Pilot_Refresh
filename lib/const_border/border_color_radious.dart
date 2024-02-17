import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final verySmallRound = BorderRadius.circular(6);
final smallRound = BorderRadius.circular(12);
final largeRound = BorderRadius.circular(22);
final borderGrey = BorderSide(color: Colors.grey);
final borderBlack = BorderSide(color: Colors.black);
final F5BorderColor = Border.all(color: Color(0xFFF5F5F5));
final textFildContentPadding =  EdgeInsets.symmetric(horizontal: 15, vertical: 20);

final customBorderPackage = OutlineInputBorder(
  borderRadius: smallRound,
  borderSide: borderGrey,
);
final customFocusBorder = OutlineInputBorder(
  borderRadius: smallRound,
  borderSide: borderBlack,
);

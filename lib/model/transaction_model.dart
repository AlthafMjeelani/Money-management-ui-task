import 'package:flutter/material.dart';

class TransactionModel {
  final String name;
  final Widget icon;
  final String date;
  final String price;
  final String type;


  TransactionModel(
      {required this.date,
      required this.price,
      required this.name,
      required this.type,
      required this.icon});
}



class GridDataModel {
  final String name;
  final String des;
  final String price;


  GridDataModel(
      {required this.des,
      required this.price,
      required this.name,});
}

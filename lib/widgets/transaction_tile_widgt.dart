
import 'dart:ui';

import 'package:demotask/helper/core/color_constant.dart';
import 'package:demotask/model/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionTileWidget extends StatelessWidget {
  const TransactionTileWidget({
    super.key, required this.value,
  });
final TransactionModel value;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColoring.kAppWhiteColor,
      leading: 
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: const Color(0xffDEE6EE),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: value.icon,
          ),
        ),
       title: Text(
          value.name,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColoring.blackLight),
        ),
        subtitle: Text(
          value.date,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColoring.textDim),
        ),
        trailing: Text(
          value.price,
          style:  TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color:value.type=='i'? AppColoring.successPopup:AppColoring.errorPopUp),
        ),
      
    );
  }
}

import 'package:demotask/helper/core/color_constant.dart';
import 'package:demotask/model/category_model.dart';
import 'package:demotask/model/transaction_model.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  final categoryList = [
    CategoryModel(
        name: 'Change',
        icon: const Icon(Icons.change_circle_outlined,
            color: AppColoring.textDim)),
    CategoryModel(
        name: 'Transfer',
        icon: const Icon(Icons.arrow_upward, color: AppColoring.textDim)),
    CategoryModel(
        name: 'Incomming',
        icon: const Icon(Icons.arrow_downward, color: AppColoring.textDim)),
    CategoryModel(
        name: 'Receipt',
        icon:
            const Icon(Icons.receipt_long_rounded, color: AppColoring.textDim)),
    CategoryModel(
        name: 'More',
        icon: const Icon(Icons.grid_view, color: AppColoring.textDim)),
  ];

  final transactionList = [
    TransactionModel(
        name: 'Rental Income',
        icon: const Icon(Icons.home, color: AppColoring.textDim),
        date: '14 July 2021',
        price: '+6,500.00',
        type: 'i'),
    TransactionModel(
        name: 'Grocery Shopping',
        icon: const Icon(Icons.shopping_cart, color: AppColoring.textDim),
        date: '22 July 2021',
        price: '-300.49',
        type: 'e'),
    TransactionModel(
        name: 'Grocery Shopping',
        icon: const Icon(Icons.shopping_cart, color: AppColoring.textDim),
        date: '22 July 2021',
        price: '-300.49',
        type: 'e'),
  ];

  final incomeTransactionList = [
    TransactionModel(
        name: 'Rental Income',
        icon: const Icon(Icons.home, color: AppColoring.textDim),
        date: '14 July 2021',
        price: '+6,500.00',
        type: 'i'),
    TransactionModel(
        name: 'Business Income',
        icon: const Icon(Icons.business_sharp, color: AppColoring.textDim),
        date: '22 July 2021',
        price: '+300.49',
        type: 'i'),
    TransactionModel(
        name: 'Payment from Eric',
        icon: const SizedBox(),
        date: '22 July 2021',
        price: '+300.49',
        type: 'i'),
  ];

  final expenceTransactionList = [
    TransactionModel(
        name: 'Grocery Shopping',
        icon: const Icon(Icons.shopping_cart, color: AppColoring.textDim),
        date: '22 July 2021',
        price: '-300.49',
        type: 'e'),
    TransactionModel(
        name: 'Pay to Employees',
        icon: const Icon(Icons.attach_money_sharp, color: AppColoring.textDim),
        date: '20 July 2021',
        price: '-6,500.00',
        type: 'e'),
    TransactionModel(
        name: 'Health Expenditures',
        icon: const Icon(Icons.favorite, color: AppColoring.textDim),
        date: '22 July 2021',
        price: '-300.49',
        type: 'e'),
  ];

  final gridDataModel = [
    GridDataModel(
        name: 'Shopping',
        des: 'Mauris hendrerit mollis bibendum quisque.',
        price: '1400'),
        
    GridDataModel(
        name: 'Savings',
        des: 'Ut pulvinar arcu lacus a sit amet posuere.',
        price: '2700'),
    GridDataModel(
        name: 'Education',
        des: 'Maecenas quis purus at metus posuere dapib.',
        price: '1400'),
    GridDataModel(
        name: 'Bank Loan',
        des: 'Proin sagittis imperdiet egestas aenean maxi.',
        price: '2100'),
  ];

int selectedIndex=0;

  final List tabBarData=[
    'This Week',
    'Last Week',
    'Last Month',
    'Last Year',
  ];


   final allTransactionList = [
    TransactionModel(
        name: 'Rental Income',
        icon: const Icon(Icons.home, color: AppColoring.textDim),
        date: '14 July 2021',
        price: '+6,500.00',
        type: 'i'),
         TransactionModel(
        name: 'Grocery Shopping',
        icon: const Icon(Icons.shopping_cart, color: AppColoring.textDim),
        date: '22 July 2021',
        price: '-300.49',
        type: 'e'),
    TransactionModel(
        name: 'Pay to Employees',
        icon: const Icon(Icons.attach_money_sharp, color: AppColoring.textDim),
        date: '20 July 2021',
        price: '-6,500.00',
        type: 'e'),
   
    TransactionModel(
        name: 'Business Income',
        icon: const Icon(Icons.business_sharp, color: AppColoring.textDim),
        date: '22 July 2021',
        price: '+300.49',
        type: 'i'),
         TransactionModel(
        name: 'Health Expenditures',
        icon: const Icon(Icons.favorite, color: AppColoring.textDim),
        date: '22 July 2021',
        price: '-300.49',
        type: 'e'),
    TransactionModel(
        name: 'Payment from Eric',
        icon: const SizedBox(),
        date: '22 July 2021',
        price: '+300.49',
        type: 'i'),
  ];
}

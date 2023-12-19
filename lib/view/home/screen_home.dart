import 'package:demotask/controller/home/home_controller.dart';
import 'package:demotask/helper/core/app_spacing.dart';
import 'package:demotask/helper/core/color_constant.dart';
import 'package:demotask/model/transaction_model.dart';
import 'package:demotask/view/home/add_transaction_screen.dart';
import 'package:demotask/view/home/widget/card_widget.dart';
import 'package:demotask/widgets/heading_widget.dart';
import 'package:demotask/widgets/transaction_tile_widgt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
         
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddTransaction(),
          ));
        },
        child: const CircleAvatar(
          radius: 30,
          backgroundColor: AppColoring.cardColor,
          child: Center(
            child: Icon(
              Icons.add,
              color: AppColoring.kAppWhiteColor,
              size: 35,
            ),
          ),
        ),
      ),
      backgroundColor: AppColoring.lightBg,
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: AppColoring.lightBg,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffDEE6EE)),
          ),
          AppSpacing.ksizedBoxW10,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Text(
              'Welcome,',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const Text(
              'Indigo Violet',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColoring.textDim),
            ),
            AppSpacing.ksizedBox20,
            const CardWidget(),
            AppSpacing.ksizedBox10,
            const HeadingWidget(
              title: 'Easy Operations',
            ),
            AppSpacing.ksizedBox10,
            Consumer(builder: (context, HomeController value, _) {
              return SizedBox(
                height: 80,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: AppColoring.kAppWhiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: value.categoryList[index].icon,
                            ),
                          ),
                          Text(
                            value.categoryList[index].name,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColoring.textDim),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        AppSpacing.ksizedBoxW30,
                    itemCount: value.categoryList.length),
              );
            }),
            AppSpacing.ksizedBox10,
            const HeadingWidget(
              title: 'Previous Transactions',
            ),
            AppSpacing.ksizedBox10,
            Consumer(builder: (context, HomeController value, _) {
              return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TransactionTileWidget(
                      value: value.transactionList[index],
                    );
                  },
                  separatorBuilder: (context, index) => AppSpacing.ksizedBox10,
                  itemCount: value.transactionList.length);
            }),
          ],
        ),
      ),
    );
  }
}

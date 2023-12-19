import 'package:demotask/controller/home/home_controller.dart';
import 'package:demotask/helper/core/app_spacing.dart';
import 'package:demotask/helper/core/color_constant.dart';
import 'package:demotask/view/statistic/screen_statistics3.dart';
import 'package:demotask/view/statistic/scrren_statistics2.dart';
import 'package:demotask/widgets/heading_widget.dart';
import 'package:demotask/widgets/transaction_tile_widgt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenCategory extends StatelessWidget {
  const ScreenCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColoring.lightBg,
      appBar: AppBar(
        backgroundColor: AppColoring.lightBg,
        elevation: 0,
        title: const Text(
          'All Transactions',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: [
          Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xffDEE6EE),
            ),
          ),
          AppSpacing.ksizedBoxW10,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Text(
              '₹12,400.00',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const Text(
              'My Total Earnings',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColoring.textDim),
            ),
            AppSpacing.ksizedBox20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HeadingWidget(title: 'All My Expenses'),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ScreenSecondStatistics(),
                      ),
                    );
                  },
                  child: const Text(
                    'Seel All',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColoring.textDim),
                  ),
                )
              ],
            ),
            AppSpacing.ksizedBox10,
            Consumer(builder: (context, HomeController value, _) {
              return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TransactionTileWidget(
                      value: value.expenceTransactionList[index],
                    );
                  },
                  separatorBuilder: (context, index) => AppSpacing.ksizedBox10,
                  itemCount: value.expenceTransactionList.length);
            }),
            AppSpacing.ksizedBox20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const HeadingWidget(title: 'All My Income'),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ScreenStatisticsThree(),
                      ),
                    );
                  },
                  child: const Text(
                    'Seel All',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColoring.textDim),
                  ),
                )
              ],
            ),
            AppSpacing.ksizedBox10,
            Consumer(builder: (context, HomeController value, _) {
              return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TransactionTileWidget(
                      value: value.incomeTransactionList[index],
                    );
                  },
                  separatorBuilder: (context, index) => AppSpacing.ksizedBox10,
                  itemCount: value.incomeTransactionList.length);
            }),
          ],
        ),
      ),
    );
  }
}

import 'package:demotask/controller/home/home_controller.dart';
import 'package:demotask/helper/core/app_spacing.dart';
import 'package:demotask/helper/core/color_constant.dart';
import 'package:demotask/view/statistic/scrren_statistics2.dart';
import 'package:demotask/widgets/heading_widget.dart';
import 'package:demotask/widgets/transaction_tile_widgt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScreenStatisticsThree extends StatelessWidget {
  const ScreenStatisticsThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColoring.lightBg,
      appBar: AppBar(
        backgroundColor: AppColoring.lightBg,
        elevation: 0,
        title: const Text(
          'Statistics',
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
           
            AppSpacing.ksizedBox10,
            Consumer(builder: (context, HomeController value, _) {
              return SizedBox(
                height: 40,
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 10,
                         width: 110,
                        decoration: BoxDecoration(
                            color:value.selectedIndex==index?AppColoring.cardColor: AppColoring.textDim.withOpacity(.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(value.tabBarData[index],style: TextStyle(color: value.selectedIndex==index?AppColoring.kAppWhiteColor:AppColoring.textDim),),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        AppSpacing.ksizedBoxW10,
                    itemCount: value.tabBarData.length),
              );
            }),
            AppSpacing.ksizedBox10,
          Container(
            child: SfCartesianChart(
              title: ChartTitle(text: ''),
              primaryXAxis: CategoryAxis(),
              series: <ChartSeries>[
                ColumnSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Jan', 30),
                    SalesData('Feb', 50),
                    SalesData('Mar', 20),
                    SalesData('Apr', 70),
                  ],
                  xValueMapper: (SalesData sales, _) => sales.month,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  name: 'Sales',
                ),
              ],
            ),
          ),
    

            AppSpacing.ksizedBox10,
            Consumer(builder: (context, HomeController value, _) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return TransactionTileWidget(value: value.allTransactionList[index],);
                  },
                  separatorBuilder: (context, index) =>
                      AppSpacing.ksizedBox10,
                  itemCount: value.allTransactionList.length);
            }),
          ],
        ),
      ),
    );
  }
}

class MyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(), // Assuming your X-axis contains categorical data
      primaryYAxis: NumericAxis(), // Assuming your Y-axis contains numeric data
      series: <ChartSeries>[
        BarSeries<SalesData, String>(
          // isTransposed: true, // Set to true for bottom-to-top bars
          isTrackVisible: true,

          dataSource: <SalesData>[
            SalesData('Jan', 35),
            SalesData('Feb', 28),
            SalesData('Mar', 34),
            SalesData('Apr', 32),
            SalesData('May', 40),
          ],
          xValueMapper: (SalesData sales, _) => sales.month,
          yValueMapper: (SalesData sales, _) => sales.sales,
        ),
      ],
    );
  }
}

class SalesData {
  final String month;
  final double sales;

  SalesData(this.month, this.sales);
}
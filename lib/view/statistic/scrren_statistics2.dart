import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:demotask/controller/home/home_controller.dart';
import 'package:demotask/helper/core/app_spacing.dart';
import 'package:demotask/helper/core/color_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScreenSecondStatistics extends StatelessWidget {
  const ScreenSecondStatistics({super.key});

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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColoring.kAppWhiteColor,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, left: 10),
                  child: DropdownButtonFormField(
                    elevation: 0,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Monthly',
                        contentPadding: EdgeInsets.zero),
                    items: [],
                    onChanged: (value) {},
                  ),
                ),
              ),
            ),
            AppSpacing.ksizedBox15,
            Center(
              child: Container(
                height: 300,
                child: _buildCircularChart(),
              ),
            ),
            AppSpacing.ksizedBox20,
            Consumer(
              builder: (context,HomeController value,_) {
                return GridView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisExtent: 130),
                  itemBuilder: (context, index) {
                    return  CardWidget(
                      desc: value.gridDataModel[index].des,
                      heading: value.gridDataModel[index].name,
                      price: value.gridDataModel[index].price,
                    )
                    
                    ;
                  },
                );
              }
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCircularChart() {
    return SfCircularChart(
      series: _getDoughnutSeries(),
       annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          widget: Container(
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total Income',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,color: AppColoring.textDim),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '₹6,000',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<DoughnutSeries<_ChartData, String>> _getDoughnutSeries() {
    final List<_ChartData> chartData = [
      _ChartData('A', 25, const Color.fromARGB(255, 148, 169, 246)),
      _ChartData('B', 25, Colors.blue),
      _ChartData('C', 25, Colors.green),
      _ChartData('D', 25, AppColoring.cardColor),
    ];

    return <DoughnutSeries<_ChartData, String>>[
      DoughnutSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData data, _) => data.category,
        yValueMapper: (_ChartData data, _) => data.value,
        pointColorMapper: (_ChartData data, _) => data.color,
        innerRadius: '80%', // Adjust inner radius as needed
        startAngle: 90,
        endAngle: 90 + 360,
        
      )
    ];
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.heading,
    required this.price,
    required this.desc,
  });
  final String heading;
  final String price;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: AppColoring.kAppWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 5,
                  backgroundColor: AppColoring.cardColor,
                ),
                AppSpacing.ksizedBoxW5,
                Text(
                  heading,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
               
              ],
            ),
             AppSpacing.ksizedBox10,
                Text(
                  '₹$price',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800,color: AppColoring.cardColor),
                ),
                AppSpacing.ksizedBox10,
                Text(
                  desc,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.category, this.value, this.color);

  final String category;
  final double value;
  final Color color;
}

import 'package:demotask/helper/core/app_spacing.dart';
import 'package:demotask/helper/core/color_constant.dart';
import 'package:demotask/widgets/heading_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ScreenStatistics extends StatelessWidget {
  const ScreenStatistics({super.key});

  final double progressValue = 0.0;

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'July 2022',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            AppSpacing.ksizedBox10,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      '₹10,320.40',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'income',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '₹74,320.40',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Expense',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            AppSpacing.ksizedBox15,
            const HeadingWidget(title: 'Income Rate'),
            AppSpacing.ksizedBox10,
            LinearProgressIndicator(
              minHeight: 12,
              borderRadius: BorderRadius.circular(10),
              value: 0.37, // Adjust the value between 0 and 1
              valueColor: AlwaysStoppedAnimation<Color>(
                _getColor(0.37),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0k',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColoring.textDim),
                ),
                Text(
                  '27k',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: AppColoring.textDim),
                ),
              ],
            ),
            AppSpacing.ksizedBox15,
            const HeadingWidget(title: 'Total Success this Month'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        series: <LineSeries<ChartData, String>>[
                          LineSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y,
                          ),
                        ],
                        enableSideBySideSeriesPlacement: true,
                        trackballBehavior: TrackballBehavior(
                          enable: true,
                          activationMode: ActivationMode.singleTap,
                          lineColor: Colors.blue,
                          lineWidth: 2,
                          markerSettings: const TrackballMarkerSettings(
                            borderWidth: 2,
                            height: 8,
                            width: 8,
                            markerVisibility: TrackballVisibilityMode.visible,
                          ),
                          tooltipSettings: const InteractiveTooltip(
                            enable: true,
                            color: Colors.blue,
                            format: 'point.y',
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.ksizedBox15,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Income',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColoring.textDim),
                        ),
                        Text(
                          '₹8.5k',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    AppSpacing.ksizedBox10,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Expense',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: AppColoring.textDim),
                        ),
                        Text(
                          '₹3.5k',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    AppSpacing.ksizedBox10,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '₹11.5k',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColoring.cardColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getColor(double value) {
    if (value <= 0.1) {
      return AppColoring.cardColor;
    } else if (value <= 0.5) {
      return AppColoring.cardColor;
    } else {
      return AppColoring.cardColor;
    }
  }
}

List<ChartData> chartData = [
  ChartData(x: 'Jan', y: 30),
  ChartData(x: 'Feb', y: 42),
  ChartData(x: 'Mar', y: 28),
  // Add more data points as needed
];

class ChartData {
  final String x;
  final double y;

  ChartData({required this.x, required this.y});
}

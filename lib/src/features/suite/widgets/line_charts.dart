// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

import 'package:vmodel/src/res/res.dart';

import '../../../core/utils/helper_functions.dart';

int numberOfDays = 0;

final minBarIndexProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});

class LineChartWithDots extends ConsumerStatefulWidget {
  final List<double> dataPoints;
  final Function(Offset offset, String details) onTap;

  LineChartWithDots({required this.dataPoints, required this.onTap});

  @override
  ConsumerState<LineChartWithDots> createState() => _LineChartWithDotsState();
}

class _LineChartWithDotsState extends ConsumerState<LineChartWithDots> {
  List<IndividualBarData> individualBarData = [];
  List<ChartDataSet> chartDataSet = [];
  final int barsPerPage = 8;

  @override
  initState() {
    super.initState();
    getBarGroup(0);
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen(minBarIndexProvider, (p, n) {
    //   print('Prev: $p and next: $n');

    //   getBarGroup(n);
    // });
    // final minBarIndexState = ref.watch(minBarIndexProvider);

    // final List<IndividualBarData> individualBarData = [];
    individualBarData = [];
    for (int index = 0; index < widget.dataPoints.length; index++) {
      individualBarData
          .add(IndividualBarData(x: index, y: widget.dataPoints[index]));
    }
    numberOfDays = individualBarData.length;
    // BarData myBarData = BarData(
    //   data1: widget.dataPoints[0],
    //   data2: widget.dataPoints[1],
    //   data3: widget.dataPoints[2],
    //   data4: widget.dataPoints[3],
    //   data5: widget.dataPoints[4],
    //   data6: widget.dataPoints[5],
    //   data7: widget.dataPoints[6],
    //   data9: widget.dataPoints[7],
    // );
    // myBarData.initializeBarData();

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification? overscroll) {
        overscroll!
            .disallowIndicator(); //Don't show scroll splash/ripple effect
        return true;
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 350,
          // color: Colors.amber,
          // margin: EdgeInsets.only(top: 100),
          width: widget.dataPoints.length * 40,
          child: BarChart(
            BarChartData(
              // maxY: 100,
              minY: 0,
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              // groupsSpace: 1000,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Colors.white,
                  tooltipMargin: 20,
                  tooltipPadding: EdgeInsets.all(4),
                  getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                  ) {
                    return BarTooltipItem(
                      '${rod.toY.toInt()}',
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                        color: rod.color,
                        fontSize: 9.sp,
                        // shadows: const [
                        //   Shadow(
                        //     color: Colors.black26,
                        //     blurRadius: 12,
                        //   )
                        // ],
                      ),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                  leftTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                          reservedSize: 32,
                          showTitles: true,
                          getTitlesWidget: bottomText))),
              barGroups: individualBarData
                  .map(
                    (data) => BarChartGroupData(
                      x: data.x,
                      barRods: [
                        BarChartRodData(
                          toY: data.y,
                          width: 16,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(5)),
                          color: Color(0xFF3897F0),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
    // return GestureDetector(
    //     onHorizontalDragEnd: (DragEndDetails details) {
    //       print('I am dragging ${details.primaryVelocity}');
    //       if (details.primaryVelocity! > 0 && minBarIndexState > 0) {
    //         // controller.updateXMinValue(controller.xMinValue - 1);
    //         print('Dragging if');
    //         ref.read(minBarIndexProvider.notifier).state = minBarIndexState - 1;
    //       } else if (details.primaryVelocity! < 0 &&
    //           chartDataSet.last.index > minBarIndexState + 5) {
    //         print('Dragging else if');
    //         // controller.updateXMinValue(controller.xMinValue + 1);
    //         ref.read(minBarIndexProvider.notifier).state = minBarIndexState + 1;
    //       }
    //     },
    //     child: BarChart(
    //       BarChartData(
    //           // maxY: 100,
    //           minY: 0,
    //           gridData: FlGridData(show: false),
    //           borderData: FlBorderData(show: false),
    //           // groupsSpace: 1000,
    //           barTouchData: BarTouchData(
    //             enabled: true,
    //             touchTooltipData: BarTouchTooltipData(
    //               tooltipBgColor: Colors.white,
    //               tooltipMargin: 20,
    //               tooltipPadding: EdgeInsets.all(4),
    //               getTooltipItem: (
    //                 BarChartGroupData group,
    //                 int groupIndex,
    //                 BarChartRodData rod,
    //                 int rodIndex,
    //               ) {
    //                 return BarTooltipItem(
    //                   '${rod.toY.toInt()}',
    //                   TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     // color: Colors.white,
    //                     color: rod.color,
    //                     fontSize: 9.sp,
    //                     // shadows: const [
    //                     //   Shadow(
    //                     //     color: Colors.black26,
    //                     //     blurRadius: 12,
    //                     //   )
    //                     // ],
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //           titlesData: FlTitlesData(
    //               leftTitles:
    //                   AxisTitles(sideTitles: SideTitles(showTitles: false)),
    //               rightTitles:
    //                   AxisTitles(sideTitles: SideTitles(showTitles: false)),
    //               topTitles:
    //                   AxisTitles(sideTitles: SideTitles(showTitles: false)),
    //               bottomTitles: AxisTitles(
    //                   sideTitles: SideTitles(
    //                       reservedSize: 32,
    //                       showTitles: true,
    //                       getTitlesWidget: bottomText))),
    //           barGroups: chartDataSet.map((e) => e.barData).toList()
    //           // individualBarData.map(
    //           //   (data) {
    //           //     print('dataX: ${data.x}');
    //           //     return BarChartGroupData(
    //           //       // x: data.x,
    //           //       x: data.x,
    //           //       // barsSpace: 1000,
    //           //       barRods: [
    //           //         BarChartRodData(
    //           //           toY: data.y,
    //           //           width: 16,
    //           //           borderRadius: BorderRadius.circular(5),
    //           //           color: Color(0xFF3897F0),
    //           //         ),
    //           //       ],
    //           //     );
    //           //   },
    //           // ).toList(),
    //           ),
    //     ));
  }

  List<ChartDataSet> getBarGroup(int minBarIndex) {
    // final List<ChartDataSet> allBars = [];
    print(
        'Min of these ${barsPerPage} , ${widget.dataPoints.length - (minBarIndex + 1)}');
    final lastPageIndex =
        chartDataSet.length > 0 ? chartDataSet.last.index : barsPerPage;
    chartDataSet = [];
    for (int i = minBarIndex;
        i < min(lastPageIndex, widget.dataPoints.length);
        i++) {
      chartDataSet.add(ChartDataSet(
          index: i,
          barData: BarChartGroupData(
            x: i,
            // barsSpace: 1000,
            barRods: [
              BarChartRodData(
                toY: widget.dataPoints[i],
                width: 16,
                borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                color: Color(0xFF3897F0),
              ),
            ],
          )));
    }
    setState(() {});
    return chartDataSet;
  }
}

List<String> getLastDays(int days) {
  List<String> lastDays = [];

  // Get the current date
  DateTime currentDate = DateTime.now();

  // Iterate backwards for the last 8 days
  for (int i = days; i >= 0; i--) {
    // Subtract i days from the current date
    DateTime day = currentDate.subtract(Duration(days: i));
    String textDays = '${day.day}${getDayOfMonthSuffix(day.day)}';

    lastDays.add(textDays);
  }

  return lastDays;
}

Widget bottomText(double index, TitleMeta meta) {
  List<String> days = getLastDays(numberOfDays);
  var style = TextStyle(
    fontFamily: "OpenSans",
    fontSize: 14,
    color: VmodelColors.white,
  );
  Widget? text;
  switch (index.toInt()) {
    case 0:
      text = Text(days[0], style: style);
      break;
    case 1:
      text = Text(days[1], style: style);
      break;
    case 2:
      text = Text(days[2], style: style);
      break;
    case 3:
      text = Text(days[3], style: style);
      break;
    case 4:
      text = Text(days[4], style: style);
      break;
    case 5:
      text = Text(days[5], style: style);
      break;
    case 6:
      text = Text(days[6], style: style);
      break;
    case 7:
      text = Text(days[7], style: style);
      break;
    case 8:
      text = Text(days[8], style: style);
      break;
    case 9:
      text = Text(days[9], style: style);
      break;
    case 10:
      text = Text(days[10], style: style);
      break;
    case 11:
      text = Text(days[11], style: style);
      break;
    case 12:
      text = Text(days[12], style: style);
      break;
    case 13:
      text = Text(days[13], style: style);
      break;
    case 14:
      text = Text(days[14], style: style);
      break;
    case 15:
      text = Text(days[15], style: style);
      break;
    case 16:
      text = Text(days[16], style: style);
      break;
    case 17:
      text = Text(days[17], style: style);
      break;
    case 18:
      text = Text(days[18], style: style);
      break;
    case 19:
      text = Text(days[19], style: style);
      break;
    case 20:
      text = Text(days[20], style: style);
      break;
    case 21:
      text = Text(days[21], style: style);
      break;
    case 22:
      text = Text(days[22], style: style);
      break;
    case 23:
      text = Text(days[23], style: style);
      break;
    case 24:
      text = Text(days[24], style: style);
      break;
    case 25:
      text = Text(days[25], style: style);
      break;
    case 26:
      text = Text(days[26], style: style);
      break;
    case 27:
      text = Text(days[27], style: style);
      break;
    case 28:
      text = Text(days[28], style: style);
      break;
    case 29:
      text = Text(days[29], style: style);
      break;
  }

  return SideTitleWidget(child: text!, axisSide: meta.axisSide);
}

class ChartDataSet {
  final int index;
  final BarChartGroupData barData;
  ChartDataSet({
    required this.index,
    required this.barData,
  });
}

class IndividualBarData {
  final int x; // x-coordinate on the line chart
  final double y; // Details to display when tapped

  IndividualBarData({required this.x, required this.y});
}

class BarData {
  final double data1;
  final double data2;
  final double data3;
  final double data4;
  final double data5;
  final double data6;
  final double data7;
  final double data9;

  BarData({
    required this.data1,
    required this.data2,
    required this.data3,
    required this.data4,
    required this.data5,
    required this.data6,
    required this.data7,
    required this.data9,
  });
  List<IndividualBarData> barData = [];
  void initializeBarData() {
    barData = [
      IndividualBarData(x: 0, y: data1),
      IndividualBarData(x: 1, y: data2),
      IndividualBarData(x: 2, y: data3),
      IndividualBarData(x: 3, y: data4),
      IndividualBarData(x: 4, y: data5),
      IndividualBarData(x: 5, y: data6),
      IndividualBarData(x: 6, y: data7),
      IndividualBarData(x: 7, y: data9),
    ];
  }
}




/*



    return Container(
      height: 250,
      // color: Colors.amber,
      width: widget.dataPoints.length * 40,
      child: BarChart(
        BarChartData(
          // maxY: 100,
          minY: 0,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          // groupsSpace: 1000,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.white,
              tooltipMargin: 20,
              tooltipPadding: EdgeInsets.all(4),
              getTooltipItem: (
                BarChartGroupData group,
                int groupIndex,
                BarChartRodData rod,
                int rodIndex,
              ) {
                return BarTooltipItem(
                  '${rod.toY.toInt()}',
                  TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Colors.white,
                    color: rod.color,
                    fontSize: 9.sp,
                    // shadows: const [
                    //   Shadow(
                    //     color: Colors.black26,
                    //     blurRadius: 12,
                    //   )
                    // ],
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      reservedSize: 32,
                      showTitles: true,
                      getTitlesWidget: bottomText))),
          barGroups: individualBarData
              .map(
                (data) => BarChartGroupData(
                  x: data.x,
                  barsSpace: 1000,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      width: 16,
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFF3897F0),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );




 */
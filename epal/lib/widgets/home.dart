import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      width: 300,
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          Container(
            height: 200,
            width: 150,
            child: SfCartesianChart(),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
          ),
          Container(
            height: 200,
            width: 150,
            child: SfSparkLineChart(
              data: <double>[
                1,
                5,
                -6,
                0,
                1,
                -2,
                7,
                -7,
                -4,
                -10,
                13,
                -6,
                7,
                5,
                11,
                5,
                3
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
          ),
          Container(
            height: 200,
            width: 150,
            child: SfCircularChart(
              title: ChartTitle(text: 'Sales by sales person'),
              series: <CircularSeries>[
                RadialBarSeries<SalesData, String>(
                  dataSource: SalesData.getData(),
                  xValueMapper: (SalesData sales, _) => sales.salesPerson,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                )
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
          ),
          Container(
            height: 200,
            width: 150,
            child: SfCartesianChart(),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1)),
          ),
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.salesPerson, this.sales);

  final String salesPerson;
  final double sales;

  static List<SalesData> getData() {
    return <SalesData>[
      SalesData('David', 35),
      SalesData('Steve', 28),
      SalesData('Jack', 34),
      SalesData('Others', 32),
    ];
  }
}

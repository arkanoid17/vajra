import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:vajra/models/sales_history_data/sales_history.dart';
import 'package:vajra/resource_helper/strings.dart';

class BarChartComponent extends StatefulWidget{

  final List<SalesHistoryData> listSalesHistory;
  final String chartView;

  const BarChartComponent ({ Key? key, required this.listSalesHistory, required this.chartView }): super(key: key);

  @override
  State<BarChartComponent> createState() => _BarChartComponent();
}

class _BarChartComponent extends State<BarChartComponent>{
  @override
  Widget build(BuildContext context) {
    return BarChart(
        BarChartData(
            barGroups: _chartGroups(),
            borderData: FlBorderData(
                border: const Border(bottom: BorderSide(), left: BorderSide()),
            ),
        gridData:FlGridData(show: false),
            titlesData:FlTitlesData(
              bottomTitles: AxisTitles(sideTitles: _bottomTitles),
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),

        )
    );
  }

  List<BarChartGroupData> _chartGroups() {

    if(widget.chartView==AppStrings.billed){
      return widget.listSalesHistory.map((point) =>
          BarChartGroupData(
              x: widget.listSalesHistory.indexOf(point),
              barRods: [
                BarChartRodData(
                    toY: point.orders!.toDouble(),
                )
              ]
          )

      ).toList();
    }

    if(widget.chartView==AppStrings.ptr){
      return widget.listSalesHistory.map((point) =>
          BarChartGroupData(
              x: widget.listSalesHistory.indexOf(point),
              barRods: [
                BarChartRodData(
                  toY: double.parse(point.ptr!),
                )
              ]
          )

      ).toList();
    }

    if(widget.chartView==AppStrings.nrv){
      return widget.listSalesHistory.map((point) =>
          BarChartGroupData(
              x: widget.listSalesHistory.indexOf(point),
              barRods: [
                BarChartRodData(
                  toY: double.parse(point.nrv!),
                )
              ]
          )

      ).toList();
    }


    return [];
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value,meta){
      return Text(widget.listSalesHistory[value.toInt()].date!);
    }
  );

}
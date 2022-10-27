import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vajra/models/sales_history_data/sales_history.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';

class BarChartComponent extends StatefulWidget{

  final List<SalesHistoryData> listSalesHistory;
  final String chartView;

  const BarChartComponent ({ Key? key, required this.listSalesHistory, required this.chartView }): super(key: key);

  @override
  State<BarChartComponent> createState() => _BarChartComponent();
}

class _BarChartComponent extends State<BarChartComponent>{

  List<SalesHistoryData> data = [];

  @override
  void initState() {
    // if(widget.listSalesHistory.length<10){
    //   data = widget.listSalesHistory;
    // }else{
    //   data.add(widget.listSalesHistory[0]);
    //   var firstDate = DateFormat('yyyy-MM-dd').parse(widget.listSalesHistory[0].date!);
    //   var lastDate = DateFormat('yyyy-MM-dd').parse(widget.listSalesHistory[(widget.listSalesHistory.length-1)].date!);
    //
    //   var daysBetWeen = DateTimeRange(
    //       start: firstDate,
    //       end: lastDate
    //     )
    //       .duration
    //       .inDays;
    //
    //   var inBetweenPoints = widget.listSalesHistory.length-2;
    //   var intervals =  daysBetWeen~/inBetweenPoints;
    //
    //   List<String> dates = [];
    //
    //   for (SalesHistoryData dt in widget.listSalesHistory){
    //     if(DateFormat('yyyy-MM-dd').parse(dt.date!)==firstDate){
    //       dates.add(dt.date!);
    //     }else if(DateFormat('yyyy-MM-dd').parse(dt.date!)==lastDate){
    //       dates.add(dt.date!);
    //     }else{
    //       var lastExistingDate = DateFormat('yyyy-MM-dd').parse(dates[dates.length]);
    //       if()
    //     }
    //   }
    //
    //
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
        BarChartData(
            barGroups: _chartGroups(),
            barTouchData: BarTouchData(enabled: true),
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

        ),
      swapAnimationDuration: const Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear,
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
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                  
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorConstants.colorPrimary,
                      ColorConstants.color_ECE6F6_20
                    ]
                  )
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
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                    
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorConstants.colorPrimary,
                          ColorConstants.color_ECE6F6_20
                        ]
                    )
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
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorConstants.colorPrimary,
                          ColorConstants.color_ECE6F6_20
                        ]
                    )
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
      return Transform.rotate(
        angle: -340,
        child: Text(widget.listSalesHistory[value.toInt()].date!),
      );
    }
  );

  SideTitles get _leftTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value,meta){
      return Text('$value');
    }
  );

}
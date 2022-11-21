
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

    List<SalesHistoryData> values = [];

    if(widget.listSalesHistory.length<10){
      values = widget.listSalesHistory;
    }else{
      double interval = widget.listSalesHistory.length/10;
      double carryOver = 0;

      for(int i = 0;i<10;i++){

        int intervalPoint = (interval+carryOver).toInt();
        carryOver = interval-intervalPoint;

        String dates = '';
        int orders = 0;
        double ptr = 0.0,nrv = 0.0;


        //date
        if(intervalPoint<1){
          dates = widget.listSalesHistory[data.length].date!;
        }else{
          dates = '${widget.listSalesHistory[data.length].date!} - ${widget.listSalesHistory[(data.length+intervalPoint)-1].date!} ';
        }

        //orders,ptr,nrv
        for(int j = 0;j < intervalPoint;j++){
          orders = orders+widget.listSalesHistory[data.length+j].orders!;
          ptr = ptr+double.parse(widget.listSalesHistory[data.length+j].ptr!);
          nrv = nrv+double.parse(widget.listSalesHistory[data.length+j].nrv!);
        }

        values.add(SalesHistoryData(dates, orders, nrv.toString(), ptr.toString()));
      }

      print(values.length);
      setState(() {
        data = values;
      });

    }
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
      return data.map((point) =>
          BarChartGroupData(
              x: data.indexOf(point),
              barRods: [
                BarChartRodData(
                    toY: point.orders!.toDouble(),
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                  
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorConstants.colorPrimary,
                      ColorConstants.color_ECE6F6_32
                    ]
                  )
                )
              ]
          )

      ).toList();
    }

    if(widget.chartView==AppStrings.ptr){
      return data.map((point) =>
          BarChartGroupData(
              x: data.indexOf(point),
              barRods: [
                BarChartRodData(
                  toY: double.parse(point.ptr!),
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                    
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorConstants.colorPrimary,
                          ColorConstants.color_ECE6F6_32
                        ]
                    )
                )
              ]
          )

      ).toList();
    }

    if(widget.chartView==AppStrings.nrv){
      return data.map((point) =>
          BarChartGroupData(
              x: data.indexOf(point),

              barRods: [
                BarChartRodData(
                  toY: double.parse(point.nrv!),
                    borderRadius: const BorderRadius.all(Radius.circular(0)),
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ColorConstants.colorPrimary,
                          ColorConstants.color_ECE6F6_32
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
        child: Text(data[value.toInt()].date!),
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
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vajra/models/chart_dates/chart_dates.dart';
import 'package:vajra/resource_helper/strings.dart';

class DateDropDown extends StatefulWidget{

  final String selected;
  final Function onDateSelected;

  const DateDropDown({Key? key, required this.selected, required this.onDateSelected})
      : super(key: key);

  @override
  State<DateDropDown> createState() => _DateDropDown();
}

class _DateDropDown extends State<DateDropDown>{

  List<ChartDates> names = [];
  var formatter = DateFormat('dd-MM-yyyy');

  String getFirstDayOfWeek(){
    var dateTime = DateTime.now();
    dateTime = dateTime.subtract(Duration(days: dateTime.weekday - 1));
    return formatter.format(dateTime);
  }

  String getFirstDayOfMonth(){
    var dateTime = DateTime.now();
    return '01-${dateTime.month}-${dateTime.year}';
  }

  void getAvailableDates(){
    names.add(ChartDates(AppStrings.today,formatter.format(DateTime.now()),formatter.format(DateTime.now())));
    names.add(ChartDates(AppStrings.currentWeek,getFirstDayOfWeek(),formatter.format(DateTime.now())));
    names.add(ChartDates(AppStrings.currentMonth,getFirstDayOfMonth(),formatter.format(DateTime.now())));
  }

  @override
  void initState() {
    getAvailableDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
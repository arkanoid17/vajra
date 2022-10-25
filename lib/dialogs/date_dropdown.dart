import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/db/pending_task_data_detail/pending_task_data_detail.dart';
import 'package:vajra/models/chart_dates/chart_dates.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/utils/app_utils.dart';

class DateDropDown extends StatefulWidget {
  final String selected;
  final Function onDateSelected;
  final SharedPreferences prefs;

  const DateDropDown(
      {Key? key,
      required this.selected,
      required this.prefs,
      required this.onDateSelected})
      : super(key: key);

  @override
  State<DateDropDown> createState() => _DateDropDown();
}

class _DateDropDown extends State<DateDropDown> {
  List<ChartDates> names = [];
  var formatter = DateFormat('yyyy-MM-dd');

  String getFirstDayOfWeek() {
    var dateTime = DateTime.now();
    dateTime = dateTime.subtract(Duration(days: dateTime.weekday - 1));
    return formatter.format(dateTime);
  }

  String getFirstDayOfMonth() {
    var dateTime = DateTime.now();
    dateTime = DateTime(dateTime.year, dateTime.month, 1);
    return formatter.format(dateTime);
  }

  String getYesterdayDate() {
    var dateTime = DateTime.now().subtract(Duration(days: 1));
    return formatter.format(dateTime);
  }

  String getFirstDatePreviousWeek() {
    var dateTime = DateTime.now();
    dateTime = dateTime.subtract(const Duration(days: 7));
    dateTime = dateTime.subtract(Duration(days: dateTime.weekday - 1));
    return formatter.format(dateTime);
  }

  String getLastDatePreviousWeek() {
    var dateTime = DateTime.now();
    dateTime = dateTime.subtract(const Duration(days: 7));
    dateTime = dateTime.subtract(Duration(days: dateTime.weekday - 1));
    dateTime = dateTime.add(Duration(days: 7));
    return formatter.format(dateTime);
  }

  String getFirstDatePreviousMonth() {
    var dateTime = DateTime.now();
    dateTime = DateTime(dateTime.year, dateTime.month - 1, 1);
    return formatter.format(dateTime);
  }

  String getLastDatePreviousMonth() {
    var dateTime = DateTime.now();
    dateTime = DateTime(dateTime.year, dateTime.month - 1, dateTime.day);
    var days = DateTimeRange(
            start: DateTime(dateTime.year, dateTime.month, 1),
            end: DateTime(dateTime.year, dateTime.month + 1))
        .duration
        .inDays;
    dateTime = DateTime(dateTime.year, dateTime.month, days);

    return formatter.format(dateTime);
  }

  String getFirstDateOfPastThirdMonth() {
    var dateTime = DateTime.now();
    dateTime = DateTime(dateTime.year, dateTime.month - 3, 1);
    return formatter.format(dateTime);
  }

  String getFirstDateOfCurrentFy() {
    return AppUtils.getFyDate(widget.prefs);
  }

  String getLastDayOfCurrentFY() {
    var dateTime = formatter.parse(AppUtils.getFyDate(widget.prefs));
    dateTime = DateTime(dateTime.year + 1, dateTime.month, dateTime.day);
    return formatter.format(dateTime);
  }

  String getFirstDateOfPreviousFy() {
    var dateTime = formatter.parse(AppUtils.getFyDate(widget.prefs));
    dateTime = DateTime(dateTime.year - 1, dateTime.month, dateTime.day);
    return formatter.format(dateTime);
  }

  String getLastDayOfPreviousFY() {
    var dateTime = formatter.parse(AppUtils.getFyDate(widget.prefs));
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day - 1);
    return formatter.format(dateTime);
  }

  void getAvailableDates() {
    names.add(ChartDates(AppStrings.today, formatter.format(DateTime.now()),
        formatter.format(DateTime.now())));
    names.add(ChartDates(AppStrings.currentWeek, getFirstDayOfWeek(),
        formatter.format(DateTime.now())));
    names.add(ChartDates(AppStrings.currentMonth, getFirstDayOfMonth(),
        formatter.format(DateTime.now())));
    names.add(ChartDates(
        AppStrings.yesterday, getYesterdayDate(), getYesterdayDate()));
    names.add(ChartDates(AppStrings.lastWeek, getFirstDatePreviousWeek(),
        getLastDatePreviousWeek()));
    names.add(ChartDates(AppStrings.lastMonth, getFirstDatePreviousMonth(),
        getLastDatePreviousMonth()));
    names.add(ChartDates(AppStrings.past3Months, getFirstDateOfPastThirdMonth(),
        formatter.format(DateTime.now())));
    names.add(ChartDates(AppStrings.currentFy, getFirstDateOfCurrentFy(),
        getLastDayOfCurrentFY()));
    names.add(ChartDates(AppStrings.previousFy, getFirstDateOfPreviousFy(),
        getLastDayOfPreviousFY()));
    names.add(ChartDates(AppStrings.selectDateRange, '', ''));
  }

  bool getSelected(String? item) {
    return item == widget.selected;
  }

  void showRangePicker() {
    Navigator.pop(context);
    var today = DateTime.now();
    var firstDate = DateTime(today.year - 5, 1, 1);
    var lastDate = DateTime(today.year + 5, 1, 1);
    var picked = showDateRangePicker(
        context: context,
        firstDate: firstDate,
        lastDate: lastDate,
        initialDateRange: DateTimeRange(
          end: DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          start: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 5),
        ),
        builder: (context, child) {
          return Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400.0,
                ),
                child: child,
              )
            ],
          );
        }).then((value) => {
          if(value!=null){
            widget.onDateSelected(AppStrings.selectDateRange,formatter.format(value.start),formatter.format(value.end))
          }
    });


  }

  @override
  void initState() {
    getAvailableDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          const Center(
            child: Text(
              AppStrings.selectOption,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: names.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${names[index].option}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: getSelected(names[index].option)
                                          ? ColorConstants.colorPrimary
                                          : Colors.black),
                                ),
                                names[index].startDate!.isNotEmpty
                                    ? Text(
                                        '${names[index].startDate} ${AppStrings.to} ${names[index].endDate}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                getSelected(names[index].option)
                                                    ? ColorConstants
                                                        .colorPrimary
                                                    : Colors.black),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                            height: 1,
                          ),
                          getSelected(names[index].option)
                              ? const Icon(
                                  Icons.check,
                                  color: ColorConstants.colorPrimary,
                                )
                              : Container()
                        ],
                      ),
                    ),
                    onTap: () => {
                      names[index].option == AppStrings.selectDateRange
                          ? showRangePicker()
                          : {
                              widget.onDateSelected(names[index].option,names[index].startDate,names[index].endDate),
                              Navigator.pop(context)
                            }
                    },
                  );
                }),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

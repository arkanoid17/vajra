import 'package:intl/intl.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';

class DateUtils {
  static getTodayDate(String format) {
    return DateFormat(format).format(DateTime.now());
  }

  static int getWeekOfMonth(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);

    // Calculate the week number
    int weekOfMonth = ((date.day + firstDayOfMonth.weekday - 1) / 7).ceil();

    return weekOfMonth;
  }

  static String getDayOfWeek(dateString) {
    DateTime date = DateTime.parse(dateString);
    int weekday = date.weekday;

    // Return the day of the week as a string
    return AppStrings.days[weekday - 1];
  }

  static int getDifferenceInHours(DateTime d1, DateTime d2) {
    return d1.difference(d2).inHours;
  }
}

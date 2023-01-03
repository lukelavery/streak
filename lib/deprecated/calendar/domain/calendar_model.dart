import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarProvider = Provider.autoDispose<CalendarBaseModel>(
    (ref) => CalendarBaseModel());

class CalendarBaseModel {
  final List<String> days = ['m', 't', 'w', 't', 'f', 's', 's'];
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'september',
    'October',
    'November',
    'December',
  ];

  String getMonthString(DateTime dateTime) {
    return months[dateTime.month - 1];
  }

  int getMonthLength(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month + 1, 0).day;
  }

  int getStartDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, 1).weekday;
  }

  int getEndDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month + 1, 0).weekday;
  }

  DateTime getPreviousMonth(DateTime dateTime) {
    if (dateTime.month == 1) {
      return DateTime(dateTime.year - 1, 12);
    } else {
      return DateTime(dateTime.year, dateTime.month - 1);
    }
  }

  DateTime getSubsequentMonth(DateTime dateTime) {
    if (dateTime.month == 12) {
      return DateTime(dateTime.year + 1, 1);
    } else {
      return DateTime(dateTime.year, dateTime.month + 1);
    }
  }

  List<DateTime> getPreviousMonthDates(DateTime dateTime) {
    List<DateTime> dateTimes = [];
    int startDay = getStartDay(dateTime);
    DateTime previousMonth = getPreviousMonth(dateTime);
    int previousMonthLength = getMonthLength(previousMonth);

    for (int i = 0; i < startDay - 1; i++) {
      dateTimes.insert(
          0,
          DateTime(previousMonth.year, previousMonth.month,
              previousMonthLength - i));
    }

    return dateTimes;
  }

  List<DateTime> getCurrentMonthDates(DateTime dateTime) {
    List<DateTime> dateTimes = [];
    int monthLength = getMonthLength(dateTime);

    for (int i = 0; i < monthLength; i++) {
      dateTimes.add(DateTime(dateTime.year, dateTime.month, i + 1));
    }
    return dateTimes;
  }

  List<DateTime> getDates(DateTime dateTime) {
    List<DateTime> dateTimes = [];
    List<DateTime> previousMonthDates = getPreviousMonthDates(dateTime);
    List<DateTime> currentMonthDates = getCurrentMonthDates(dateTime);
    int monthLength = getMonthLength(dateTime);
    int remainingDays = 42 - (monthLength + previousMonthDates.length);
    DateTime subsequentMonth = getSubsequentMonth(dateTime);

    for (DateTime d in previousMonthDates) {
      dateTimes.add(d);
    }

    for (DateTime d in currentMonthDates) {
      dateTimes.add(d);
    }

    for (int i = 0; i < remainingDays; i++) {
      dateTimes
          .add(DateTime(subsequentMonth.year, subsequentMonth.month, i + 1));
    }

    return dateTimes;
  }
}

class CalendarModel {
  CalendarModel(this.dateTime, this.dates, this.dateView);

  final DateTime dateTime;
  final List<DateTime> dates;
  final DateTime dateView;
}

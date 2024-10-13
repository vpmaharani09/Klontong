extension DateTimeExtension on DateTime {
  bool isBeforeOrSameTime(DateTime comparator) {
    return isBefore(comparator) || isAtSameMomentAs(comparator);
  }

  bool isAfterOrSameTime(DateTime comparator) {
    return isAfter(comparator) || isAtSameMomentAs(comparator);
  }

  DateTime startOfDay() => DateTime(year, month, day);

  DateTime getLast30Days() => subtract(const Duration(days: 30));

  DateTime endOfDay() => DateTime(year, month, day)
      .add(const Duration(days: 1))
      .subtract(const Duration(milliseconds: 1));
}

/// DateFormat.
enum DateFormat {
  DEFAULT, //yyyy-MM-dd HH:mm:ss.SSS
  NORMAL, //yyyy-MM-dd HH:mm:ss
  YEAR_MONTH_DAY_HOUR_MINUTE, //yyyy-MM-dd HH:mm
  YEAR_MONTH_DAY, //yyyy-MM-dd
  YEAR_MONTH, //yyyy-MM
  YEAR_ONLY, //yyyy
  MONTH_DAY, //MM-dd
  MONTH_DAY_HOUR_MINUTE, //MM-dd HH:mm
  HOUR_MINUTE_SECOND, //HH:mm:ss
  HOUR_MINUTE, //HH:mm
}

class DataFormats {
  static String DEFAULT = "yyyy-MM-dd HH:mm:ss";
  static String YEAR_MONTH_DAY_HOUR_MINUTE = "yyyy-MM-dd HH:mm";
  static String YEAR_MONTH_DAY = "yyyy-MM-dd";
  static String YEAR_MONTH = "yyyy-MM";
  static String MONTH_DAY = "MM-dd";
  static String MONTH_DAY_HOUR_MINUTE = "MM-dd HH:mm";
  static String HOUR_MINUTE_SECOND = "HH:mm:ss";
  static String HOUR_MINUTE = "HH:mm";
}

class DateUtils {
  /// get DateTime By DateStr.
  static DateTime? getDateTime(String dateStr, {bool isUtc = false}) {
    DateTime? dateTime = DateTime.tryParse(dateStr);
    if (isUtc) {
      dateTime = dateTime?.toUtc();
    } else {
      dateTime = dateTime?.toLocal();
    }
    return dateTime;
  }

  /// get Now Date Milliseconds.
  static int getNowDateMilliSecond() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String formatDateTime(String time, DateFormat format,
      String? dateSeparate, String? timeSeparate) {
    var newTime = "";
    switch (format) {
      case DateFormat.NORMAL: //yyyy-MM-dd HH:mm:ss
        newTime = time.substring(0, "yyyy-MM-dd HH:mm:ss".length);
        break;
      case DateFormat.YEAR_MONTH_DAY_HOUR_MINUTE: //yyyy-MM-dd HH:mm
        newTime = time.substring(0, "yyyy-MM-dd HH:mm".length);
        break;
      case DateFormat.YEAR_MONTH_DAY: //yyyy-MM-dd
        newTime = time.substring(0, "yyyy-MM-dd".length);
        break;
      case DateFormat.YEAR_MONTH: //yyyy-MM
        newTime = time.substring(0, "yyyy-MM".length);
        break;
      case DateFormat.YEAR_ONLY: //yyyy
        newTime = time.substring(0, "yyyy".length);
        break;
      case DateFormat.MONTH_DAY: //MM-dd
        newTime = time.substring("yyyy-".length, "yyyy-MM-dd".length);
        break;
      case DateFormat.MONTH_DAY_HOUR_MINUTE: //MM-dd HH:mm
        newTime = time.substring("yyyy-".length, "yyyy-MM-dd HH:mm".length);
        break;
      case DateFormat.HOUR_MINUTE_SECOND: //HH:mm:ss
        newTime = newTime.substring(
            "yyyy-MM-dd ".length, "yyyy-MM-dd HH:mm:ss".length);
        break;
      case DateFormat.HOUR_MINUTE: //HH:mm
        newTime =
            time.substring("yyyy-MM-dd ".length, "yyyy-MM-dd HH:mm".length);
        break;
      case DateFormat.DEFAULT:
        break;
    }
    final newTimeSeparate =
        dateTimeSeparate(newTime, dateSeparate, timeSeparate);
    return newTimeSeparate;
  }

  /// date Time Separate.
  static String dateTimeSeparate(
    String time,
    String? dateSeparate,
    String? timeSeparate,
  ) {
    var newTime = "";
    if (dateSeparate != null) {
      newTime = time.replaceAll("-", dateSeparate);
    }

    if (timeSeparate != null) {
      newTime = time.replaceAll(":", timeSeparate);
    }
    return newTime;
  }
}

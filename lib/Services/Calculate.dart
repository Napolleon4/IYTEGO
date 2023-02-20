import 'package:intl/intl.dart';

class Calculator {
  static String datetimetoString(DateTime dateTime) {
    String formattedtodate = DateFormat("dd-MM-yyy").format(dateTime);
    return formattedtodate;
  }
}

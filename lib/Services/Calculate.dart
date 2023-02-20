import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class Calculator {
  static String datetimetoString(DateTime dateTime) {
    String formattedtodate = DateFormat("dd-MM-yyy").format(dateTime);
    return formattedtodate;
  }
}

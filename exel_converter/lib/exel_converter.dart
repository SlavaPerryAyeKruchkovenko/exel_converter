library exel_converter;

import 'dart:io';

import 'package:excel/excel.dart';

import 'models/schedule.dart';

class Converter {
  /// Returns Schedule from plus 1.
  Iterable<Schedule> convertToSchedule(File value) {
    var data = value.readAsBytesSync();

    var excel = Excel.decodeBytes(data);
    var tables = excel.tables;
    for (var key in tables.keys) {
      if (tables[key] != null) {
        tables.cell(0);
      }
    }

    throw Exception("");
  }
}

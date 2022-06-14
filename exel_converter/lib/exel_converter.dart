library exel_converter;

import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:excel/excel.dart';
import 'package:exel_converter/models/week_schedule.dart';

import 'models/schedule.dart';

class Converter {
  /// Returns Schedule from plus 1.
  Iterable<Schedule> convertToSchedule(File value) {
    var data = value.readAsBytesSync();
    List<Schedule> schedules = [];
    var excel = Excel.decodeBytes(data);
    var tables = excel.tables;
    for (var key in tables.keys) {
      if (tables[key] != null) {
        var sheet = tables[key]!;
        int groupCount = 0;
        int start = "C".codeUnitAt(0);
        try {
          groupCount++;
          start += 2;
          schedules.add(_getSchedule(sheet, start));
        } catch (ex) {
          if (groupCount <= 0) {
            throw Exception("$ex");
          }
        }
      } else {
        throw Exception('incorrect Excel list $key');
      }
    }
    return schedules;
  }

  Schedule _getSchedule(
    Sheet sheet,
    int start,
  ) {
    var nameIndex = _getStartOfTable(sheet, String.fromCharCode(start));
    var arr = sheet.cell(nameIndex).value.toString().split(' ');
    var name = arr[0];
    var groupNum = int.parse(arr[1]);
    return Schedule(
        schedules: _getSchedules(), groupName: name, groupNum: groupNum);
  }

  List<WeekSchedule> _getSchedules() {
    throw Exception();
  }

  CellIndex _getStartOfTable(Sheet sheet, String letter) {
    var maxIndex = 15;
    CellIndex? cellIndex;
    for (var i = 0; i <= maxIndex; i++) {
      cellIndex = CellIndex.indexByString(letter + i.toString());
      var cellArr = sheet.cell(cellIndex).value.toString().split(' ');
      if (cellArr.length == 2 && int.tryParse(cellArr[1]) != null) {
        return cellIndex;
      }
    }
    throw Exception("haven't title of group");
  }
}

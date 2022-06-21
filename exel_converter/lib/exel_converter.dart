library exel_converter;

import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe
import 'package:excel/excel.dart';
import 'package:exel_converter/models/day_schedule.dart';
import 'package:exel_converter/models/week_schedule.dart';

import 'models/schedule.dart';

class Converter {
  /// Returns Schedule from plus 1.
  Iterable<Schedule> convertToSchedule(File value) {
    var data = value.readAsBytesSync();
    var excel = Excel.decodeBytes(data);
    var tables = excel.tables;
    return _parseTables(tables);
  }

  List<Schedule> _parseTables(
    tables,
  ) {
    List<Schedule> schedules = [];
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
      }
    }
    if (schedules.isEmpty) throw Exception('schebules not found');
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
        schedules: _getWeekSchedules(sheet, nameIndex),
        groupName: name,
        groupNum: groupNum);
  }

  List<WeekSchedule> _getWeekSchedules(Sheet sheet, CellIndex start) {
    List<WeekSchedule> weekSchedules = [];
    var startRow = start.rowIndex + 1;
    var dayIndex = CellIndex.indexByColumnRow(
        columnIndex: "A".codeUnitAt(0), rowIndex: startRow);
    List<DaySchedule> frtPairs = [];
    List<DaySchedule> secondPairs = [];
    _getDayEnd(sheet, dayIndex);
    return weekSchedules;
  }

  DaySchedule _getDaySchedule() {
    throw Exception();
  }

  CellIndex _getDayEnd(Sheet sheet, CellIndex start) {
    CellStyle style = sheet.cell(start).cellStyle;
    var a = style.backgroundColor;
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

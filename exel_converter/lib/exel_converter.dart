library exel_converter;

import 'dart:io';
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
        var groupCount = 0;
        try {
          var nameIndex = _getStartOfTable(sheet, "C");

          while (true) {
            schedules.add(_getSchedule(sheet, nameIndex));
            groupCount++;
            nameIndex = CellIndex.indexByColumnRow(
                columnIndex: nameIndex.columnIndex + 2,
                rowIndex: nameIndex.rowIndex);
          }
        } catch (ex) {
          if (groupCount <= 0) {
            //throw Exception("$ex");
          }
        }
      }
    }
    if (schedules.isEmpty) throw Exception('schebules not found');
    return schedules;
  }

  Schedule _getSchedule(
    Sheet sheet,
    CellIndex nameIndex,
  ) {
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
    var dayIndex =
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: startRow);
    List<DaySchedule> frtPairs = [];
    List<DaySchedule> secondPairs = [];
    //_getDayEnd(sheet, dayIndex);
    return weekSchedules;
  }

  DaySchedule _getDaySchedule() {
    throw Exception();
  }

  CellIndex _getDayEnd(Sheet sheet, CellIndex start) {
    CellStyle? style = sheet.cell(start).cellStyle;
    var a = style!.backgroundColor;
    throw Exception();
  }

  CellIndex _getStartOfTable(Sheet sheet, String letter) {
    var maxIndex = 15;
    CellIndex? cellIndex;
    for (var i = 11; i <= maxIndex; i++) {
      cellIndex = CellIndex.indexByString(letter + i.toString());

      var cellArr = sheet.cell(cellIndex).value.toString().split(' ');
      if (cellArr.length >= 2 && int.tryParse(cellArr[1]) != null) {
        return cellIndex;
      }
    }
    throw Exception("haven't title of group");
  }
}

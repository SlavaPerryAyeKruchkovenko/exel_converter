import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pair {
  final int pair;
  late final TimeOfDay pairStart;
  late final TimeOfDay pairFinish;
  final String subjectName;
  final String cabinet;
  final String lecturer;

  Pair(
      {required this.pair,
      required this.subjectName,
      required this.cabinet,
      required this.lecturer,
      required pairStart,
      required pairFinish}) {
    this.pairStart = _getTime(pairStart, "start");
    this.pairFinish = _getTime(pairStart, "finish");
  }

  TimeOfDay _getTime(time, String type) {
    if (time is TimeOfDay) {
      return pairStart;
    } else if (time is String) {
      final format = DateFormat.jm();
      return TimeOfDay.fromDateTime(format.parse(time));
    }
    throw Exception("inccorect type of pair $type");
  }
}

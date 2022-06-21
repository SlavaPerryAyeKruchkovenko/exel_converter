import 'dart:io';

import 'package:exel_converter/exel_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test 1 execel file', () {
    var file = File('D:\\test\\test.xlsx');
    Converter().convertToSchedule(file);
  });
}

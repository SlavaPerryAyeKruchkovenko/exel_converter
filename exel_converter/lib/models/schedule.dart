import 'week_schedule.dart';

class Schedule {
  final List<WeekSchedule> schedules;
  final String groupName;
  final int groupNum;
  Schedule(
      {required this.schedules,
      required this.groupName,
      required this.groupNum});
}

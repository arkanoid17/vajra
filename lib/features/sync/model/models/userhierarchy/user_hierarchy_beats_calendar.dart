import 'package:hive/hive.dart';

part 'user_hierarchy_beats_calendar.g.dart';

@HiveType(typeId: 8, adapterName: 'UserHierarchyBeatCalendarAdapter')
class UserHierarchyBeatCalendar {
  @HiveField(0)
  int? id;

  @HiveField(1)
  int? weekNo;

  @HiveField(2)
  String? dayName;

  UserHierarchyBeatCalendar({this.id, this.weekNo, this.dayName});

  UserHierarchyBeatCalendar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weekNo = json['week_no'];
    dayName = json['day_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['week_no'] = this.weekNo;
    data['day_name'] = this.dayName;
    return data;
  }
}



import 'package:json_annotation/json_annotation.dart';

part 'hierarchy_beat_calendar.g.dart';

@JsonSerializable()
class HierarchyBeatCalendar{

  @JsonKey(name:'id')
  int? id;
  
  @JsonKey(name:'week_no')
  int? weekNo;
  
  @JsonKey(name:'day_name')
  String? dayName;

  HierarchyBeatCalendar(this.id, this.weekNo, this.dayName);

  factory HierarchyBeatCalendar.fromJson(Map<String, dynamic> json) => _$HierarchyBeatCalendarFromJson(json);

  Map<String?, dynamic> toJson() => _$HierarchyBeatCalendarToJson(this);
}
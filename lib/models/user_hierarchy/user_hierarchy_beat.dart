

import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/user_hierarchy/hierarchy_beat_calendar.dart';
part 'user_hierarchy_beat.g.dart';


@JsonSerializable()
class UserHierarchyBeat{
  @JsonKey(name:'id')
  int? id;
  
  @JsonKey(name:'calendar')
  List<HierarchyBeatCalendar>? calendar;
  
  @JsonKey(name:'tenant_id')
  String? tenantId;
  
  @JsonKey(name:'name')
  String? name;
  
  @JsonKey(name:'description')
  String? description;
  
  @JsonKey(name:'type')
  String? type;
  
  @JsonKey(name:'created_at')
  String? createdAt;
  
  @JsonKey(name:'updated_at')
  String? updatedAt;
  
  @JsonKey(name:'created_by')
  int? createdBy;
  
  bool? selected;

  UserHierarchyBeat(
      this.id,
      this.calendar,
      this.tenantId,
      this.name,
      this.description,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.selected);

  factory UserHierarchyBeat.fromJson(Map<String, dynamic> json) => _$UserHierarchyBeatFromJson(json);

  Map<String?, dynamic> toJson() => _$UserHierarchyBeatToJson(this);
}
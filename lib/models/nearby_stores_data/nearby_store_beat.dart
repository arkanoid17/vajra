import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/user_hierarchy/hierarchy_beat_calendar.dart';

part 'nearby_store_beat.g.dart';

@JsonSerializable()
class NearbyStoreBeat{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'calendar')
  List<HierarchyBeatCalendar>? calendar;
  @JsonKey(name: 'tenant_id')
  String? tenantId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'status')
  bool? status;
  @JsonKey(name: 'company_code')
  String? companyCode;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'created_by')
  int? createdBy;

  NearbyStoreBeat(
      this.id,
      this.calendar,
      this.tenantId,
      this.name,
      this.status,
      this.companyCode,
      this.description,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.createdBy);

  factory NearbyStoreBeat.fromJson(Map<String, dynamic> json) => _$NearbyStoreBeatFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyStoreBeatToJson(this);
}
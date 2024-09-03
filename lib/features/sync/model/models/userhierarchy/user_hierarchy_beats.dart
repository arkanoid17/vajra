import 'package:hive/hive.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats_calendar.dart';

part 'user_hierarchy_beats.g.dart';

@HiveType(typeId: 7, adapterName: 'UserHierarchyBeatsAdapter')
class UserHierarchyBeats {
  @HiveField(0)
  int? id;

  @HiveField(1)
  List<UserHierarchyBeatCalendar>? calendar;

  @HiveField(2)
  String? tenantId;

  @HiveField(3)
  String? name;

  @HiveField(4)
  bool? status;

  @HiveField(5)
  String? companyCode;

  @HiveField(6)
  String? description;

  @HiveField(7)
  String? type;

  @HiveField(8)
  String? createdAt;

  @HiveField(9)
  String? updatedAt;

  @HiveField(10)
  int? createdBy;

  UserHierarchyBeats(
      {this.id,
      this.calendar,
      this.tenantId,
      this.name,
      this.status,
      this.companyCode,
      this.description,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.createdBy});

  UserHierarchyBeats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['calendar'] != null) {
      calendar = <UserHierarchyBeatCalendar>[];
      json['calendar'].forEach((v) {
        calendar!.add(UserHierarchyBeatCalendar.fromJson(v));
      });
    }
    tenantId = json['tenant_id'];
    name = json['name'];
    status = json['status'];
    companyCode = json['company_code'];
    description = json['description'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    if (this.calendar != null) {
      data['calendar'] = this.calendar!.map((v) => v.toJson()).toList();
    }
    data['tenant_id'] = this.tenantId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['company_code'] = this.companyCode;
    data['description'] = this.description;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    return data;
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/login/employee_groups.dart';
import 'package:vajra/models/login/employee_settings.dart';
part 'employee_data.g.dart';

@JsonSerializable()
class EmployeeData {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'employ_name')
  String? employeeName;

  @JsonKey(name: 'employ_id')
  String? employeeId;

  @JsonKey(name: 'groups')
  List<EmployeeGroups>? groups;

  @JsonKey(name: 'settings')
  EmployeeSettings? settings;

  @JsonKey(name: 'last_login')
  String? lastLogin;

  @JsonKey(name: 'tenant_id')
  String? tenantId;

  @JsonKey(name: 'user_id')
  String? userId;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'mobile_number')
  String? mobileNumber;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'is_external')
  bool? isExternal;

  @JsonKey(name: 'is_active')
  bool? isActive;

  @JsonKey(name: 'date_joined')
  String? dateJoined;

  @JsonKey(name: 'fcm_token')
  String? fcmToken;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'is_salesman')
  bool? isSalesman;

  @JsonKey(name: 'is_geo_restricted')
  bool? isGeoRestriced;

  @JsonKey(name: 'role')
  int? role;

  @JsonKey(name: 'manager')
  int? manager;

  @JsonKey(name: 'created_by')
  int? createdBy;

  @JsonKey(name: 'updated_by')
  int? updatedBy;

  @JsonKey(name: 'token')
  String? token;

  EmployeeData(
      this.id,
      this.employeeName,
      this.employeeId,
      this.groups,
      this.settings,
      this.lastLogin,
      this.tenantId,
      this.userId,
      this.name,
      this.mobileNumber,
      this.email,
      this.isExternal,
      this.isActive,
      this.dateJoined,
      this.fcmToken,
      this.createdAt,
      this.updatedAt,
      this.isSalesman,
      this.isGeoRestriced,
      this.role,
      this.manager,
      this.createdBy,
      this.updatedBy,
      this.token);

  factory EmployeeData.fromJson(Map<String, dynamic> json) => _$EmployeeDataFromJson(json);

  Map<String?, dynamic> toJson() => _$EmployeeDataToJson(this);
}

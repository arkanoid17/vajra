import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/login/user_permissions.dart';
import 'package:vajra/models/user_data/user_category.dart';
import 'package:vajra/models/user_data/user_group.dart';
import 'package:vajra/models/user_data/user_settings.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_beat.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_location.dart';
import 'package:vajra/models/user_hierarchy/user_hierarchy_salesman_distributors.dart';
part 'user_data.g.dart';


@JsonSerializable()
class UserData {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'employ_name')
  String? employName;

  @JsonKey(name: 'employ_id')
  String? employId;

  @JsonKey(name: 'groups')
  List<UserGroup>? groups;

  @JsonKey(name: 'settings')
  UserSettings? settings;

  @JsonKey(name: 'user_permissions')
  List<UserPermissions>? userPermissions ;

  @JsonKey(name: 'distributors_mapping')
  List<Object>? distributorsMapping ;

  @JsonKey(name: 'salesman_distributors')
  List<UserHierarchySalesmanDistributor>? salesmanDistributors ;

  @JsonKey(name: 'beats')
  List<UserHierarchyBeat>? beats ;

  @JsonKey(name: 'products')
  List<Object>? products ;

  @JsonKey(name: 'categories')
  List<UserCategory>? categories ;

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

  @JsonKey(name: 'place')
  int? place;

  @JsonKey(name: 'role')
  int? role;

  @JsonKey(name: 'manager')
  int? manager;

  @JsonKey(name: 'created_by')
  int? createdBy;

  @JsonKey(name: 'updated_by')
  int? updatedBy;

  @JsonKey(name: 'distributors')
  List<int>? distributors ;

  @JsonKey(name: 'locations')
  List<UserHierarchyLocation>? locations ;

  @JsonKey(name: 'is_geo_restricted')
  bool? isGeoRestricted;

  UserData(
      this.id,
      this.employName,
      this.employId,
      this.groups,
      this.settings,
      this.userPermissions,
      this.distributorsMapping,
      this.salesmanDistributors,
      this.beats,
      this.products,
      this.categories,
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
      this.place,
      this.role,
      this.manager,
      this.createdBy,
      this.updatedBy,
      this.distributors,
      this.locations,
      this.isGeoRestricted);

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String?, dynamic> toJson() => _$UserDataToJson(this);
}

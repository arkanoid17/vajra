import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_beats.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_locations.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_salesman_distributors.dart';

class UserHierarchy {
  int? id;
  String? employName;
  String? employId;
  List<UserHierarchyLocations>? locations;
  List<UserHierarchySalesmanDistributors>? salesmanDistributors;
  List<UserHierarchyBeats>? beats;
  String? lastLogin;
  String? tenantId;
  String? userId;
  String? name;
  String? mobileNumber;
  String? email;
  bool? isExternal;
  bool? isActive;
  String? dateJoined;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;
  bool? isSalesman;
  bool? isGeoRestricted;
  int? place;
  int? role;
  int? manager;
  int? createdBy;
  int? updatedBy;
  List<Object>? divisions;

  UserHierarchy(
      {this.id,
      this.employName,
      this.employId,
      this.locations,
      this.salesmanDistributors,
      this.beats,
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
      this.isGeoRestricted,
      this.place,
      this.role,
      this.manager,
      this.createdBy,
      this.updatedBy,
      this.divisions});

  UserHierarchy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employName = json['employ_name'];
    employId = json['employ_id'];
    if (json['locations'] != null) {
      locations = <UserHierarchyLocations>[];
      json['locations'].forEach((v) {
        locations!.add(UserHierarchyLocations.fromJson(v));
      });
    }
    if (json['salesman_distributors'] != null) {
      salesmanDistributors = <UserHierarchySalesmanDistributors>[];
      json['salesman_distributors'].forEach((v) {
        salesmanDistributors!
            .add(UserHierarchySalesmanDistributors.fromJson(v));
      });
    }
    if (json['beats'] != null) {
      beats = <UserHierarchyBeats>[];
      json['beats'].forEach((v) {
        beats!.add(UserHierarchyBeats.fromJson(v));
      });
    }
    lastLogin = json['last_login'];
    tenantId = json['tenant_id'];
    userId = json['user_id'];
    name = json['name'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    isExternal = json['is_external'];
    isActive = json['is_active'];
    dateJoined = json['date_joined'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSalesman = json['is_salesman'];
    isGeoRestricted = json['is_geo_restricted'];
    place = json['place'];
    role = json['role'];
    manager = json['manager'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    if (json['divisions'] != null) {
      divisions = <Object>[];
      json['divisions'].forEach((v) {
        divisions!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['employ_name'] = this.employName;
    data['employ_id'] = this.employId;
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    if (this.salesmanDistributors != null) {
      data['salesman_distributors'] =
          this.salesmanDistributors!.map((v) => v.toJson()).toList();
    }
    if (this.beats != null) {
      data['beats'] = this.beats!.map((v) => v.toJson()).toList();
    }
    data['last_login'] = this.lastLogin;
    data['tenant_id'] = this.tenantId;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['is_external'] = this.isExternal;
    data['is_active'] = this.isActive;
    data['date_joined'] = this.dateJoined;
    data['fcm_token'] = this.fcmToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_salesman'] = this.isSalesman;
    data['is_geo_restricted'] = this.isGeoRestricted;
    data['place'] = this.place;
    data['role'] = this.role;
    data['manager'] = this.manager;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    if (this.divisions != null) {
      data['divisions'] = this.divisions!.map((v) => v).toList();
    }
    return data;
  }
}

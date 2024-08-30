import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy_distributor_types.dart';

class UserHierarchySalesmanDistributors {
  int? id;
  List<UserHierarchyDistributorTypes>? distributorTypes;
  String? tenantId;
  String? name;
  String? description;
  String? code;
  String? contactNumber;
  String? type;
  String? emailId;
  bool? distributorStatus;
  String? createdAt;
  String? updatedAt;
  int? territory;
  int? createdBy;
  int? updatedBy;
  List<Object>? divisions;
  List<int>? territories;

  UserHierarchySalesmanDistributors(
      {this.id,
      this.distributorTypes,
      this.tenantId,
      this.name,
      this.description,
      this.code,
      this.contactNumber,
      this.type,
      this.emailId,
      this.distributorStatus,
      this.createdAt,
      this.updatedAt,
      this.territory,
      this.createdBy,
      this.updatedBy,
      this.divisions,
      this.territories});

  UserHierarchySalesmanDistributors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['distributor_types'] != null) {
      distributorTypes = <UserHierarchyDistributorTypes>[];
      json['distributor_types'].forEach((v) {
        distributorTypes!.add(UserHierarchyDistributorTypes.fromJson(v));
      });
    }
    tenantId = json['tenant_id'];
    name = json['name'];
    description = json['description'];
    code = json['code'];
    contactNumber = json['contact_number'];
    type = json['type'];
    emailId = json['email_id'];
    distributorStatus = json['distributor_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    territory = json['territory'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    if (json['divisions'] != null) {
      divisions = <Object>[];
      json['divisions'].forEach((v) {
        divisions!.add(v);
      });
    }
    territories = json['territories'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    if (this.distributorTypes != null) {
      data['distributor_types'] = this.distributorTypes!.map((v) => v).toList();
    }
    data['tenant_id'] = this.tenantId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['code'] = this.code;
    data['contact_number'] = this.contactNumber;
    data['type'] = this.type;
    data['email_id'] = this.emailId;
    data['distributor_status'] = this.distributorStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['territory'] = this.territory;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    if (this.divisions != null) {
      data['divisions'] = this.divisions!.map((v) => v).toList();
    }
    data['territories'] = this.territories;
    return data;
  }
}

import 'distributor_types.dart';

class SalesmanDistributors {
  int? id;
  List<DistributorTypes>? distributorTypes;
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
  List<Null>? divisions;
  List<int>? territories;

  SalesmanDistributors(
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

  SalesmanDistributors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['distributor_types'] != null) {
      distributorTypes = <DistributorTypes>[];
      json['distributor_types'].forEach((v) {
        distributorTypes!.add(DistributorTypes.fromJson(v));
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
      divisions = <Null>[];
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
      data['distributor_types'] =
          this.distributorTypes!.map((v) => v.toJson()).toList();
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

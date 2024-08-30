class UserBeats {
  int? id;
  String? tenantId;
  String? name;
  bool? status;
  String? companyCode;
  String? description;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? createdBy;

  UserBeats(
      {this.id,
      this.tenantId,
      this.name,
      this.status,
      this.companyCode,
      this.description,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.createdBy});

  UserBeats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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

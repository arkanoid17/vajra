import 'package:hive/hive.dart';

part 'packs.g.dart';

@HiveType(typeId: 11, adapterName: 'PacksAdpater')
class Packs {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? tenantId;

  @HiveField(2)
  String? name;

  @HiveField(3)
  String? companyCode;

  @HiveField(4)
  String? label;

  @HiveField(5)
  int? units;

  @HiveField(6)
  bool? status;

  @HiveField(7)
  String? createdAt;

  @HiveField(8)
  String? updatedAt;

  @HiveField(9)
  int? product;

  Packs(
      {this.id,
      this.tenantId,
      this.name,
      this.companyCode,
      this.label,
      this.units,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.product});

  Packs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenant_id'];
    name = json['name'];
    companyCode = json['company_code'];
    label = json['label'];
    units = json['units'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['tenant_id'] = this.tenantId;
    data['name'] = this.name;
    data['company_code'] = this.companyCode;
    data['label'] = this.label;
    data['units'] = this.units;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product'] = this.product;
    return data;
  }
}

import 'package:hive/hive.dart';

part 'locations.g.dart';

@HiveType(typeId: 2, adapterName: 'PlacesAdapter')
class Locations extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? tenantId;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? companyCode;
  @HiveField(4)
  String? createdAt;
  @HiveField(5)
  String? updatedAt;
  @HiveField(6)
  bool? isTerritory;
  @HiveField(7)
  bool? status;
  @HiveField(8)
  int? type;
  @HiveField(9)
  int? parent;

  Locations(
      {this.id,
      this.tenantId,
      this.name,
      this.companyCode,
      this.createdAt,
      this.updatedAt,
      this.isTerritory,
      this.status,
      this.type,
      this.parent});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenant_id'];
    name = json['name'];
    companyCode = json['company_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isTerritory = json['is_territory'];
    status = json['status'];
    type = json['type'];
    parent = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['tenant_id'] = this.tenantId;
    data['name'] = this.name;
    data['company_code'] = this.companyCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_territory'] = this.isTerritory;
    data['status'] = this.status;
    data['type'] = this.type;
    data['parent'] = this.parent;
    return data;
  }
}

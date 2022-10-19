
import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/user_hierarchy/distributor_types.dart';

part 'user_hierarchy_salesman_distributors.g.dart';

@JsonSerializable()
class UserHierarchySalesmanDistributor{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'tenant_id')
  String? tenantId;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'code')
  String? code;

  @JsonKey(name: 'contact_number')
  String? contactNumber;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'email_id')
  String? emailId;

  @JsonKey(name: 'distributor_status')
  bool? distributorStatus;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'territory')
  int? territory;

  @JsonKey(name: 'created_by')
  int? createdBy;

  @JsonKey(name: 'updated_by')
  int? updatedBy;

  @JsonKey(name: 'territories')
  List<int>? territories;

  UserHierarchySalesmanDistributor(
      this.id,
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
      this.territories,
      this.distributorTypes);

  @JsonKey(name: 'distributor_types')
  List<DistributorTypes>? distributorTypes;

  factory UserHierarchySalesmanDistributor.fromJson(Map<String, dynamic> json) => _$UserHierarchySalesmanDistributorFromJson(json);

  Map<String?, dynamic> toJson() => _$UserHierarchySalesmanDistributorToJson(this);

}
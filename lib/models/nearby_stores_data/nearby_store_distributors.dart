import 'package:json_annotation/json_annotation.dart';
part 'nearby_store_distributors.g.dart';

@JsonSerializable()
class NearbyStoreDistributors{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'tenant_id')
  String? tenantId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  Object? description;
  @JsonKey(name: 'code')
  String? code;
  @JsonKey(name: 'contact_number')
  String? contactNumber;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'email_id')
  Object? emailId;
  @JsonKey(name: 'distributor_status')
  bool? distributorStatus;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'territory')
  Object? territory;
  @JsonKey(name: 'created_by')
  int? createdBy;
  @JsonKey(name: 'updated_by')
  int? updatedBy;
  @JsonKey(name: 'users')
  List<Object>? users;
  @JsonKey(name: 'salesmen')
  List<int>? salesmen;
  @JsonKey(name: 'territories')
  List<int>? territories;

  NearbyStoreDistributors(
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
      this.users,
      this.salesmen,
      this.territories);

  factory NearbyStoreDistributors.fromJson(Map<String, dynamic> json) => _$NearbyStoreDistributorsFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyStoreDistributorsToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'store_distributor_relation.g.dart';

@JsonSerializable()
class StoreDistributorRelation{
  @JsonKey(name: 'mapping_id')
  String? mappingId;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'distributor_id')
  int? distributorId;
  @JsonKey(name: 'outlet_id')
  String? outletId;
  @JsonKey(name: 'is_serving')
  bool? isServing;
  @JsonKey(name: 'not_serving_reason')
  String? notServingReason;
  int? selectedUser;

  StoreDistributorRelation(this.mappingId, this.id, this.distributorId,
      this.outletId, this.isServing, this.notServingReason, this.selectedUser);

  factory StoreDistributorRelation.fromJson(Map<String, dynamic> json) => _$StoreDistributorRelationFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDistributorRelationToJson(this);
}
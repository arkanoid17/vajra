import 'package:hive/hive.dart';

part 'store_distributor_relation.g.dart';

@HiveType(typeId: 19, adapterName: 'StoreDistributorRelationAdapter')
class StoreDistributorRelation {
  @HiveField(0)
  String? mappingId;

  @HiveField(1)
  int? id;

  @HiveField(2)
  int? distributorId;

  @HiveField(3)
  String? outletId;

  @HiveField(4)
  bool? isServing;

  @HiveField(5)
  String? notServingReason;

  StoreDistributorRelation(
      {this.mappingId,
      this.id,
      this.distributorId,
      this.outletId,
      this.isServing,
      this.notServingReason});

  StoreDistributorRelation.fromJson(Map<String, dynamic> json) {
    mappingId = json['mapping_id'];
    id = json['id'];
    distributorId = json['distributor_id'];
    outletId = json['outlet_id'];
    isServing = json['is_serving'];
    notServingReason = json['not_serving_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mapping_id'] = this.mappingId;
    data['id'] = this.id;
    data['distributor_id'] = this.distributorId;
    data['outlet_id'] = this.outletId;
    data['is_serving'] = this.isServing;
    data['not_serving_reason'] = this.notServingReason;
    return data;
  }
}

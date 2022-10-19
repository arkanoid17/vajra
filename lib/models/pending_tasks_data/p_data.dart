import 'package:json_annotation/json_annotation.dart';

part 'p_data.g.dart';

@JsonSerializable()
class PData{
  @JsonKey(name: 'zone_id')
  int? zoneId;

  @JsonKey(name: 'outlet_id')
  String? storeId;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  @JsonKey(name: 'scheme_id')
  int? schemeId;

  @JsonKey(name: 'store_name')
  String? storeName;

  @JsonKey(name: 'activity_id')
  int? activityId;

  @JsonKey(name: 'document_id')
  String? documentId;

  @JsonKey(name: 'salesman_id')
  String? salesmanId;

  @JsonKey(name: 'activity_type')
  String? activityType;

  @JsonKey(name: 'document_type')
  String? documentType;

  @JsonKey(name: 'salesman_name')
  String? salesmanName;

  @JsonKey(name: 'present_status')
  String? presentStatus;

  @JsonKey(name: 'distributor_status')
  String? distributorStatus;

  @JsonKey(name: 'ase_territory_id')
  int? aseTerritoryId;

  @JsonKey(name: 'asm_territory_id')
  int? asmTerritoryId;

  PData(
      this.zoneId,
      this.storeId,
      this.imageUrl,
      this.schemeId,
      this.storeName,
      this.activityId,
      this.documentId,
      this.salesmanId,
      this.activityType,
      this.documentType,
      this.salesmanName,
      this.presentStatus,
      this.distributorStatus,
      this.aseTerritoryId,
      this.asmTerritoryId);

  factory PData.fromJson(Map<String, dynamic> json) => _$PDataFromJson(json);

  Map<String, dynamic> toJson() => _$PDataToJson(this);
}
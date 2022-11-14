import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/stores_data/store_beat.dart';
import 'images_store.dart';
import 'nearby_store_distributors.dart';
part 'nearby_stores_response.g.dart';

@JsonSerializable()
class NearbyStoresResponse{
  @JsonKey(name: 'outlet_id')
  String? outletId;
  @JsonKey(name: 'distributor_relation')
  String? distributorRelation;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'contact_no')
  String? contactNo;
  @JsonKey(name: 'alternate_no')
  String? alternateNo;
  @JsonKey(name: 'outlet_type')
  int? outletType;
  @JsonKey(name: 'channel')
  int? channel;
  @JsonKey(name: 'territory')
  int? territory;
  @JsonKey(name: 'outlet_latitude')
  String? outletLatitude;
  @JsonKey(name: 'outlet_longitude')
  String? outletLongitude;
  @JsonKey(name: 'outlet_accuracy')
  String? outletAccuracy;
  @JsonKey(name: 'store_status')
  bool? storeStatus;
  @JsonKey(name: 'company_outlet_code')
  String? companyOutletCode;
  @JsonKey(name: 'owner_name')
  String? ownerName;
  @JsonKey(name: 'distributors')
  List<NearbyStoreDistributors>? distributors;
  @JsonKey(name: 'distance')
  String? distance;
  @JsonKey(name: 'beats')
  List<StoreBeat>? beats;
  @JsonKey(name: 'images')
  ImagesStore? images;

  NearbyStoresResponse(
      this.outletId,
      this.distributorRelation,
      this.name,
      this.contactNo,
      this.alternateNo,
      this.outletType,
      this.channel,
      this.territory,
      this.outletLatitude,
      this.outletLongitude,
      this.outletAccuracy,
      this.storeStatus,
      this.companyOutletCode,
      this.ownerName,
      this.distributors,
      this.distance,
      this.beats,
      this.images);

  factory NearbyStoresResponse.fromJson(Map<String, dynamic> json) => _$NearbyStoresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NearbyStoresResponseToJson(this);

}
import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/stores_data/colours.dart';
import 'package:vajra/models/stores_data/meta_data.dart';
import 'package:vajra/models/stores_data/pricing.dart';
import 'package:vajra/models/stores_data/schemes.dart';
import 'package:vajra/models/stores_data/store_beat.dart';
import 'package:vajra/models/stores_data/store_distributor_relation.dart';

part 'store_data.g.dart';

@JsonSerializable()
class StoreData{
  @JsonKey(name: 'outlet_id')
  String? outletId;
  @JsonKey(name: 'store_id')
  String? storeId;
  @JsonKey(name: 'store_name')
  String? storeName;
  @JsonKey(name: 'store_latitude')
  String? storeLatitude;
  @JsonKey(name: 'store_longitude')
  String? storeLongitude;
  @JsonKey(name: 'beats')
  List<StoreBeat>? beats;
  @JsonKey(name: 'distributor_relation')
  List<StoreDistributorRelation>? distributorRelation;
  @JsonKey(name: 'tenant_id')
  String? tenantId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'owner_name')
  String? ownerName;
  @JsonKey(name: 'manager_name')
  String? managerName;
  @JsonKey(name: 'contact_no')
  String? contactNo;
  @JsonKey(name: 'alternate_no')
  String? alternateNo;
  @JsonKey(name: 'division')
  String? division;
  @JsonKey(name: 'outlet_latitude')
  String? outletLatitude;
  @JsonKey(name: 'outlet_longitude')
  String? outletLongitude;
  @JsonKey(name: 'outlet_accuracy')
  String? outletAccuracy;
  @JsonKey(name: 'store_status')
  bool? storeStatus;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'survey_status')
  bool? surveyStatus;
  @JsonKey(name: 'color_status')
  int? colorStatus;
  @JsonKey(name: 'otp_sent')
  bool? otpSent;
  @JsonKey(name: 'otp_verified')
  bool? otpVerified;
  @JsonKey(name: 'otp_sent_alternate')
  bool? otpSentAlternate;
  @JsonKey(name: 'otp_verified_alternate')
  bool? otpVerifiedAlternate;
  @JsonKey(name: 'sms')
  bool? sms;
  @JsonKey(name: 'tele')
  bool? tele;
  @JsonKey(name: 'email')
  bool? email;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  @JsonKey(name: 'source')
  Object? source;
  @JsonKey(name: 'company_outlet_code')
  Object? companyOutletCode;
  @JsonKey(name: 'meta_data')
  MetaData? metaData;
  @JsonKey(name: 'tax_type')
  Object? taxType;
  @JsonKey(name: 'tax_id')
  Object? taxId;
  @JsonKey(name: 'outlet_type')
  int? outletType;
  @JsonKey(name: 'channel')
  int? channel;
  @JsonKey(name: 'territory')
  int? territory;
  @JsonKey(name: 'beat')
  int? beat;
  @JsonKey(name: 'created_by')
  int? createdBy;
  @JsonKey(name: 'updated_by')
  int? updatedBy;
  @JsonKey(name: 'colours')
  List<Colours>? colours;
  @JsonKey(name: 'pricings')
  List<Pricing>? pricings;
  @JsonKey(name: 'schemes')
  List<Schemes>? schemes;

  StoreData(
      this.outletId,
      this.storeId,
      this.storeName,
      this.storeLatitude,
      this.storeLongitude,
      this.beats,
      this.distributorRelation,
      this.tenantId,
      this.name,
      this.ownerName,
      this.managerName,
      this.contactNo,
      this.alternateNo,
      this.division,
      this.outletLatitude,
      this.outletLongitude,
      this.outletAccuracy,
      this.storeStatus,
      this.description,
      this.surveyStatus,
      this.colorStatus,
      this.otpSent,
      this.otpVerified,
      this.otpSentAlternate,
      this.otpVerifiedAlternate,
      this.sms,
      this.tele,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.source,
      this.companyOutletCode,
      this.metaData,
      this.taxType,
      this.taxId,
      this.outletType,
      this.channel,
      this.territory,
      this.beat,
      this.createdBy,
      this.updatedBy,
      this.colours,
      this.pricings,
      this.schemes);

  factory StoreData.fromJson(Map<String, dynamic> json) => _$StoreDataFromJson(json);

  Map<String, dynamic> toJson() => _$StoreDataToJson(this);
}
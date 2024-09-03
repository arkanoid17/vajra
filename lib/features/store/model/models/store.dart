import 'package:hive/hive.dart';
import 'package:vajra_test/features/store/model/models/store_beats.dart';
import 'package:vajra_test/features/store/model/models/store_colours.dart';
import 'package:vajra_test/features/store/model/models/store_distributor_relation.dart';
import 'package:vajra_test/features/store/model/models/store_pricings.dart';
import 'package:vajra_test/features/store/model/models/store_schemes.dart';
import 'package:vajra_test/features/store/model/models/stores_meta_data.dart';

part 'store.g.dart';

@HiveType(typeId: 16, adapterName: 'StoreAdapter')
class Store {
  @HiveField(0)
  String? outletId;

  @HiveField(1)
  String? storeId;

  @HiveField(2)
  String? storeName;

  @HiveField(3)
  String? storeLatitude;

  @HiveField(4)
  String? storeLongitude;

  @HiveField(5)
  List<StoreBeats>? beats;

  @HiveField(6)
  List<StoreDistributorRelation>? distributorRelation;

  @HiveField(7)
  List<StoreColours>? colours;

  @HiveField(8)
  List<StorePricings>? pricings;

  @HiveField(9)
  List<StoreSchemes>? schemes;

  @HiveField(10)
  String? outerImageUrl;

  @HiveField(11)
  String? innerImageUrl;

  @HiveField(12)
  String? tenantId;

  @HiveField(13)
  String? name;

  @HiveField(14)
  String? ownerName;

  @HiveField(15)
  String? managerName;

  @HiveField(16)
  String? contactNo;

  @HiveField(17)
  String? alternateNo;

  @HiveField(18)
  String? division;

  @HiveField(19)
  String? outletLatitude;

  @HiveField(20)
  String? outletLongitude;

  @HiveField(21)
  String? outletAccuracy;

  @HiveField(22)
  bool? storeStatus;

  @HiveField(23)
  String? description;

  @HiveField(24)
  bool? surveyStatus;

  @HiveField(25)
  int? colorStatus;

  @HiveField(26)
  bool? otpSent;

  @HiveField(27)
  bool? otpVerified;

  @HiveField(28)
  bool? otpSentAlternate;

  @HiveField(29)
  bool? otpVerifiedAlternate;

  @HiveField(30)
  String? geohash;

  @HiveField(31)
  bool? sms;

  @HiveField(32)
  bool? tele;

  @HiveField(33)
  bool? email;

  @HiveField(34)
  String? createdAt;

  @HiveField(35)
  String? updatedAt;

  @HiveField(36)
  String? source;

  @HiveField(37)
  String? companyOutletCode;

  @HiveField(38)
  StoreMetaData? metaData;

  @HiveField(39)
  String? taxType;

  @HiveField(40)
  String? taxId;

  @HiveField(41)
  int? outletType;

  @HiveField(42)
  int? channel;

  @HiveField(43)
  int? territory;

  @HiveField(44)
  int? beat;

  @HiveField(45)
  int? createdBy;

  @HiveField(46)
  int? updatedBy;

  @HiveField(47)
  int? salesmanId;

  @HiveField(48)
  double? distance;

  Store(
      {this.outletId,
      this.storeId,
      this.storeName,
      this.storeLatitude,
      this.storeLongitude,
      this.beats,
      this.distributorRelation,
      this.colours,
      this.pricings,
      this.schemes,
      this.outerImageUrl,
      this.innerImageUrl,
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
      this.geohash,
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
      this.updatedBy});

  Store.fromJson(Map<String, dynamic> json) {
    outletId = json['outlet_id'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
    if (json['beats'] != null) {
      beats = <StoreBeats>[];
      json['beats'].forEach((v) {
        beats!.add(StoreBeats.fromJson(v));
      });
    }
    if (json['distributor_relation'] != null) {
      distributorRelation = <StoreDistributorRelation>[];
      json['distributor_relation'].forEach((v) {
        distributorRelation!.add(StoreDistributorRelation.fromJson(v));
      });
    }
    if (json['colours'] != null) {
      colours = <StoreColours>[];
      json['colours'].forEach((v) {
        colours!.add(StoreColours.fromJson(v));
      });
    }
    if (json['pricings'] != null) {
      pricings = <StorePricings>[];
      json['pricings'].forEach((v) {
        pricings!.add(StorePricings.fromJson(v));
      });
    }
    if (json['schemes'] != null) {
      schemes = <StoreSchemes>[];
      json['schemes'].forEach((v) {
        schemes!.add(StoreSchemes.fromJson(v));
      });
    }
    outerImageUrl = json['outer_image_url'];
    innerImageUrl = json['inner_image_url'];
    tenantId = json['tenant_id'];
    name = json['name'];
    ownerName = json['owner_name'];
    managerName = json['manager_name'];
    contactNo = json['contact_no'];
    alternateNo = json['alternate_no'];
    division = json['division'];
    outletLatitude = json['outlet_latitude'];
    outletLongitude = json['outlet_longitude'];
    outletAccuracy = json['outlet_accuracy'];
    storeStatus = json['store_status'];
    description = json['description'];
    surveyStatus = json['survey_status'];
    colorStatus = json['color_status'];
    otpSent = json['otp_sent'];
    otpVerified = json['otp_verified'];
    otpSentAlternate = json['otp_sent_alternate'];
    otpVerifiedAlternate = json['otp_verified_alternate'];
    geohash = json['geohash'];
    sms = json['sms'];
    tele = json['tele'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    source = json['source'];
    companyOutletCode = json['company_outlet_code'];
    metaData = json['meta_data'] != null
        ? StoreMetaData.fromJson(json['meta_data'])
        : null;
    taxType = json['tax_type'];
    taxId = json['tax_id'];
    outletType = json['outlet_type'];
    channel = json['channel'];
    territory = json['territory'];
    beat = json['beat'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['outlet_id'] = this.outletId;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_latitude'] = this.storeLatitude;
    data['store_longitude'] = this.storeLongitude;
    if (this.beats != null) {
      data['beats'] = this.beats!.map((v) => v.toJson()).toList();
    }
    if (this.distributorRelation != null) {
      data['distributor_relation'] =
          this.distributorRelation!.map((v) => v.toJson()).toList();
    }
    if (this.colours != null) {
      data['colours'] = this.colours!.map((v) => v.toJson()).toList();
    }
    if (this.pricings != null) {
      data['pricings'] = this.pricings!.map((v) => v.toJson()).toList();
    }
    if (this.schemes != null) {
      data['schemes'] = this.schemes!.map((v) => v.toJson()).toList();
    }
    data['outer_image_url'] = this.outerImageUrl;
    data['inner_image_url'] = this.innerImageUrl;
    data['tenant_id'] = this.tenantId;
    data['name'] = this.name;
    data['owner_name'] = this.ownerName;
    data['manager_name'] = this.managerName;
    data['contact_no'] = this.contactNo;
    data['alternate_no'] = this.alternateNo;
    data['division'] = this.division;
    data['outlet_latitude'] = this.outletLatitude;
    data['outlet_longitude'] = this.outletLongitude;
    data['outlet_accuracy'] = this.outletAccuracy;
    data['store_status'] = this.storeStatus;
    data['description'] = this.description;
    data['survey_status'] = this.surveyStatus;
    data['color_status'] = this.colorStatus;
    data['otp_sent'] = this.otpSent;
    data['otp_verified'] = this.otpVerified;
    data['otp_sent_alternate'] = this.otpSentAlternate;
    data['otp_verified_alternate'] = this.otpVerifiedAlternate;
    data['geohash'] = this.geohash;
    data['sms'] = this.sms;
    data['tele'] = this.tele;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['source'] = this.source;
    data['company_outlet_code'] = this.companyOutletCode;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.toJson();
    }
    data['tax_type'] = this.taxType;
    data['tax_id'] = this.taxId;
    data['outlet_type'] = this.outletType;
    data['channel'] = this.channel;
    data['territory'] = this.territory;
    data['beat'] = this.beat;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

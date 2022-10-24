import 'package:json_annotation/json_annotation.dart';

class StoresDataDetailFields{
  static const String outletId = 'outletId';
  static const String storeId = 'storeId';
  static const String storeName = 'storeName';
  static const String storeLatitude = 'storeLatitude';
  static const String storeLongitude = 'storeLongitude';
  static const String beats = 'beats';
  static const String distributorRelation = 'distributorRelation';
  static const String tenantId = 'tenantId';
  static const String name = 'name';
  static const String ownerName = 'ownerName';
  static const String managerName = 'managerName';
  static const String contactNo = 'contactNo';
  static const String alternateNo = 'alternateNo';
  static const String division = 'division';
  static const String outletLatitude = 'outletLatitude';
  static const String outletLongitude = 'outletLongitude';
  static const String outletAccuracy = 'outletAccuracy';
  static const String storeStatus = 'storeStatus';
  static const String description = 'description';
  static const String surveyStatus = 'surveyStatus';
  static const String colorStatus = 'colorStatus';
  static const String otpSent = 'otpSent';
  static const String otpVerified = 'otpVerified';
  static const String otpSentAlternate = 'otpSentAlternate';
  static const String otpVerifiedAlternate = 'otpVerifiedAlternate';
  static const String sms = 'sms';
  static const String tele = 'tele';
  static const String email = 'email';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
  static const String source = 'source';
  static const String companyOutletCode = 'companyOutletCode';
  static const String metaData = 'metaData';
  static const String taxType = 'taxType';
  static const String taxId = 'taxId';
  static const String outletType = 'outletType';
  static const String channel = 'channel';
  static const String territory = 'territory';
  static const String beat = 'beat';
  static const String createdBy = 'createdBy';
  static const String updatedBy = 'updatedBy';
  static const String distance = 'distance';
  static const String salesmanId = 'salesmanId';
  static const String schemes = 'schemes';
  static const String gstNumber = 'gstNumber';
  static const String licenceNumber = 'licenceNumber';
  static const String address = 'address';
  static const String remarks = 'remarks';
}
class StoresDataDetail{
  String? outletId;
  String? storeId;
  String? storeName;
  String? storeLatitude;
  String? storeLongitude;
  String? beats;
  String? distributorRelation;
  String? tenantId;
  String? name;
  String? ownerName;
  String? managerName;
  String? contactNo;
  String? alternateNo;
  String? division;
  String? outletLatitude;
  String? outletLongitude;
  String? outletAccuracy;
  bool? storeStatus;
  String? description;
  bool? surveyStatus;
  int? colorStatus;
  bool? otpSent;
  bool? otpVerified;
  bool? otpSentAlternate;
  bool? otpVerifiedAlternate;
  bool? sms;
  bool? tele;
  bool? email;
  String? createdAt;
  String? updatedAt;
  String? source;
  String? companyOutletCode;
  String? metaData;
  String? taxType;
  String? taxId;
  int? outletType;
  int? channel;
  int? territory;
  int? beat;
  int? createdBy;
  int? updatedBy;
  String? distance;
  int? salesmanId;
  String? schemes;
  String? gstNumber;
  String? licenceNumber;
  String? address;
  String? remarks;

  StoresDataDetail(
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
      this.distance,
      this.salesmanId,
      this.schemes,
      this.gstNumber,
      this.licenceNumber,
      this.address,
      this.remarks);

  Map<String, Object?> toJson() => {
    StoresDataDetailFields.outletId:outletId,
    StoresDataDetailFields.storeId:storeId,
    StoresDataDetailFields.storeName:storeName,
    StoresDataDetailFields.storeLatitude:storeLatitude,
    StoresDataDetailFields.storeLongitude:storeLongitude,
    StoresDataDetailFields.beats:beats,
    StoresDataDetailFields.distributorRelation:distributorRelation,
    StoresDataDetailFields.tenantId:tenantId,
    StoresDataDetailFields.name:name,
    StoresDataDetailFields.ownerName:ownerName,
    StoresDataDetailFields.managerName:managerName,
    StoresDataDetailFields.contactNo:contactNo,
    StoresDataDetailFields.alternateNo:alternateNo,
    StoresDataDetailFields.division:division,
    StoresDataDetailFields.outletLatitude:outletLatitude,
    StoresDataDetailFields.outletLongitude:outletLongitude,
    StoresDataDetailFields.outletAccuracy:outletAccuracy,
    StoresDataDetailFields.storeStatus:storeStatus,
    StoresDataDetailFields.description:description,
    StoresDataDetailFields.surveyStatus:surveyStatus,
    StoresDataDetailFields.colorStatus:colorStatus,
    StoresDataDetailFields.otpSent:otpSent,
    StoresDataDetailFields.otpVerified:otpVerified,
    StoresDataDetailFields.otpSentAlternate:otpSentAlternate,
    StoresDataDetailFields.otpVerifiedAlternate:otpVerifiedAlternate,
    StoresDataDetailFields.sms:sms,
    StoresDataDetailFields.tele:tele,
    StoresDataDetailFields.email:email,
    StoresDataDetailFields.createdAt:createdAt,
    StoresDataDetailFields.updatedAt:updatedAt,
    StoresDataDetailFields.source:source,
    StoresDataDetailFields.companyOutletCode:companyOutletCode,
    StoresDataDetailFields.metaData:metaData,
    StoresDataDetailFields.taxType:taxType,
    StoresDataDetailFields.taxId:taxId,
    StoresDataDetailFields.outletType:outletType,
    StoresDataDetailFields.channel:channel,
    StoresDataDetailFields.territory:territory,
    StoresDataDetailFields.beat:beat,
    StoresDataDetailFields.createdBy:createdBy,
    StoresDataDetailFields.updatedBy:updatedBy,
    StoresDataDetailFields.distance:distance,
    StoresDataDetailFields.salesmanId:salesmanId,
    StoresDataDetailFields.schemes:schemes,
    StoresDataDetailFields.gstNumber:gstNumber,
    StoresDataDetailFields.licenceNumber:licenceNumber,
    StoresDataDetailFields.address:address,
    StoresDataDetailFields.remarks:remarks
  };
}
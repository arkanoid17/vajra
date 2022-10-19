import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/user_data/price_label.dart';
part 'user_settings.g.dart';

@JsonSerializable()
class UserSettings {
  @JsonKey(name: 'file')
  Object? file;
  @JsonKey(name: 'currency')
  String? currency;
  @JsonKey(name: 'currency_symbol')
  String? currencySymbol;
  @JsonKey(name: 'fy_date')
  String? fyDate;
  @JsonKey(name: 'otp_flag')
  bool? otpFlag;
  @JsonKey(name: 'dial_code')
  String? dialCode;
  @JsonKey(name: 'time_zone')
  String? timeZone;
  @JsonKey(name: 'image_name')
  String? imageName;
  @JsonKey(name: 'welcome_msg')
  Object? welcomeMsg;
  @JsonKey(name: 'company_name')
  String? companyName;
  @JsonKey(name: 'country_code')
  String? countryCode;
  @JsonKey(name: 'gps_accuracy')
  String? gpsAccuracy;
  @JsonKey(name: 'is_gps_check')
  bool? isGpsCheck;
  @JsonKey(name: 'branding_color')
  String? brandingColor;
  @JsonKey(name: 'is_otp_allowed')
  bool? isOtpAllowed;
  @JsonKey(name: 'max_cart_value')
  int? maxCartValue;
  @JsonKey(name: 'min_cart_value')
  int? minCartValue;
  @JsonKey(name: 'near_by_radius')
  int? nearByRadius;
  @JsonKey(name: 'time_zone_name')
  String? timeZoneName;
  @JsonKey(name: 'geo_fence_radius')
  String? geoFenceRadius;
  @JsonKey(name: 'onboard_otp_flag')
  bool? onboardOtpFlag;
  @JsonKey(name: 'no_order_reason_flag')
  bool? noOrderReasonFlag;
  @JsonKey(name: 'salesman_hotline_msg')
  String? salesmanHotlineMsg;
  @JsonKey(name: 'contact_number_length')
  int? contactNumberLength;
  @JsonKey(name: 'order_confirmation_msg')
  String? orderConfirmationMsg;
  @JsonKey(name: 'default_distributor_role')
  int? defaultDistributorRole;
  @JsonKey(name: 'default_distributor_group')
  int? defaultDistributorGroup;
  @JsonKey(name: 'onboard_alternate_otp_flag')
  bool? onboardAlternateOtpFlag;
  @JsonKey(name: 'mrp')
  PriceLabel? mrp;
  @JsonKey(name: 'ptr')
  PriceLabel? ptr;
  @JsonKey(name: 'nrv')
  PriceLabel? nrv;
  @JsonKey(name: 'pts')
  PriceLabel? pts;
  @JsonKey(name: 'beat_edit_action')
  int? beatEditAction;
  @JsonKey(name: 'onboard_action')
  int? onBoardAction;
  @JsonKey(name: 'near_by_stores_limit')
  int? near_by_stores_limit;
  @JsonKey(name: 'near_by_stores_radius')
  int? near_by_stores_radius;
  @JsonKey(name: 'min_accuracy_location_update')
  int? min_accuracy_location_update;
  @JsonKey(name: 'min_time_location_update')
  int? min_time_location_update;
  @JsonKey(name: 'min_distance_location_update')
  int? min_distance_location_update;
  @JsonKey(name: 'distributor_selection_confirmation')
  bool? distributor_selection_confirmation;
  @JsonKey(name: 'allow_multiple_beats')
  bool? allow_multiple_beats;
  @JsonKey(name: 'allow_multi_line_items')
  bool? allow_multi_line_items;
  @JsonKey(name: 'auto_apply_schemes')
  bool? auto_apply_schemes;
  @JsonKey(name: 'distributor_outlet_mapping_flag')
  bool? distributor_outlet_mapping_flag;

  UserSettings(
      this.file,
      this.currency,
      this.currencySymbol,
      this.fyDate,
      this.otpFlag,
      this.dialCode,
      this.timeZone,
      this.imageName,
      this.welcomeMsg,
      this.companyName,
      this.countryCode,
      this.gpsAccuracy,
      this.isGpsCheck,
      this.brandingColor,
      this.isOtpAllowed,
      this.maxCartValue,
      this.minCartValue,
      this.nearByRadius,
      this.timeZoneName,
      this.geoFenceRadius,
      this.onboardOtpFlag,
      this.noOrderReasonFlag,
      this.salesmanHotlineMsg,
      this.contactNumberLength,
      this.orderConfirmationMsg,
      this.defaultDistributorRole,
      this.defaultDistributorGroup,
      this.onboardAlternateOtpFlag,
      this.mrp,
      this.ptr,
      this.nrv,
      this.pts,
      this.beatEditAction,
      this.onBoardAction,
      this.near_by_stores_limit,
      this.near_by_stores_radius,
      this.min_accuracy_location_update,
      this.min_time_location_update,
      this.min_distance_location_update,
      this.distributor_selection_confirmation,
      this.allow_multiple_beats,
      this.allow_multi_line_items,
      this.auto_apply_schemes,
      this.distributor_outlet_mapping_flag);

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);

  Map<String?, dynamic> toJson() => _$UserSettingsToJson(this);
}

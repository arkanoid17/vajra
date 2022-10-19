import 'package:json_annotation/json_annotation.dart';
part 'employee_settings.g.dart';

@JsonSerializable()
class EmployeeSettings {
  
  @JsonKey(name: '"file')
  String? file;
  @JsonKey(name: '"fyMonth')
  String? fyMonth;
  @JsonKey(name: '"fy_date')
  String? fyDate;
  @JsonKey(name: '"currency')
  String? currency;
  @JsonKey(name: '"otp_flag')
  bool? otpFlag;
  @JsonKey(name: '"dial_code')
  String? dialCode;
  @JsonKey(name: '"time_zone')
  String? timeZone;
  @JsonKey(name: '"image_name')
  String? imageName;
  @JsonKey(name: '"welcome_msg')
  String? welcomeMsg;
  @JsonKey(name: '"company_name')
  String? companyName;
  @JsonKey(name: '"country_code')
  String? countryCode;
  @JsonKey(name: '"gps_accuracy')
  String? gpsAccuracy;
  @JsonKey(name: '"is_gps_check')
  bool? isGpsCheck;
  @JsonKey(name: '"branding_color')
  String? brandingColor;
  @JsonKey(name: '"is_otp_allowed')
  bool? isOtpAllowed;
  @JsonKey(name: '"max_cart_value')
  int? maxCartValue;
  @JsonKey(name: '"min_cart_value')
  int? minCartValue;
  @JsonKey(name: '"near_by_radius')
  int? nearByRadius;
  @JsonKey(name: '"onboard_action')
  int? onboardAction;
  @JsonKey(name: '"time_zone_name')
  String? timeZoneName;
  @JsonKey(name: '"currency_symbol')
  String? currencySymbol;
  @JsonKey(name: '"onboard_process')
  int? onboardProcess;
  @JsonKey(name: '"attendance_query')
  String? attendanceQuery;
  @JsonKey(name: '"beat_edit_action')
  int? beatEditAction;
  @JsonKey(name: '"geo_fence_radius')
  String? geoFenceRadius;
  @JsonKey(name: '"onboard_otp_flag')
  bool? onboardOtpFlag;
  @JsonKey(name: '"beat_edit_process')
  int? beatEditProcess;
  @JsonKey(name: '"allow_multiple_beats')
  bool? allowMultipleBeats;
  @JsonKey(name: '"near_by_stores_limit')
  int? nearByStoresLimit;
  @JsonKey(name: '"no_order_reason_flag')
  bool? noOrderReasonFlag;
  @JsonKey(name: '"salesman_hotline_msg')
  String? salesmanHotlineMsg;
  @JsonKey(name: '"contact_number_length')
  int? contactNumberLength;
  @JsonKey(name: '"near_by_stores_radius')
  int? nearByStoresRadius;
  @JsonKey(name: '"onboard_alternate_otp_flag')
  bool? onboardAlternateOtpFlag;
  @JsonKey(name: '"order_confirmation_msg')
  String? orderConfirmationMsg;

  @JsonKey(name: '"default_distributor_role')
  int? defaultDistributorRole;

  @JsonKey(name: '"default_distributor_group')
  int? defaultDistributorGroup;
  @JsonKey(name: '"distributor_selection_confirmation')
  bool? distributorSelectionConfirmation;

  EmployeeSettings(
      this.file,
      this.fyMonth,
      this.fyDate,
      this.currency,
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
      this.onboardAction,
      this.timeZoneName,
      this.currencySymbol,
      this.onboardProcess,
      this.attendanceQuery,
      this.beatEditAction,
      this.geoFenceRadius,
      this.onboardOtpFlag,
      this.beatEditProcess,
      this.allowMultipleBeats,
      this.nearByStoresLimit,
      this.noOrderReasonFlag,
      this.salesmanHotlineMsg,
      this.contactNumberLength,
      this.nearByStoresRadius,
      this.orderConfirmationMsg,
      this.defaultDistributorRole,
      this.defaultDistributorGroup,
      this.onboardAlternateOtpFlag,
      this.distributorSelectionConfirmation);

  factory EmployeeSettings.fromJson(Map<String, dynamic> json) => _$EmployeeSettingsFromJson(json);

  Map<String?, dynamic> toJson() => _$EmployeeSettingsToJson(this);
}

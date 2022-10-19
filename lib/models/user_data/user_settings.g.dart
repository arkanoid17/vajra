// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) => UserSettings(
      json['file'],
      json['currency'] as String?,
      json['currency_symbol'] as String?,
      json['fy_date'] as String?,
      json['otp_flag'] as bool?,
      json['dial_code'] as String?,
      json['time_zone'] as String?,
      json['image_name'] as String?,
      json['welcome_msg'],
      json['company_name'] as String?,
      json['country_code'] as String?,
      json['gps_accuracy'] as String?,
      json['is_gps_check'] as bool?,
      json['branding_color'] as String?,
      json['is_otp_allowed'] as bool?,
      json['max_cart_value'] as int?,
      json['min_cart_value'] as int?,
      json['near_by_radius'] as int?,
      json['time_zone_name'] as String?,
      json['geo_fence_radius'] as String?,
      json['onboard_otp_flag'] as bool?,
      json['no_order_reason_flag'] as bool?,
      json['salesman_hotline_msg'] as String?,
      json['contact_number_length'] as int?,
      json['order_confirmation_msg'] as String?,
      json['default_distributor_role'] as int?,
      json['default_distributor_group'] as int?,
      json['onboard_alternate_otp_flag'] as bool?,
      json['mrp'] == null
          ? null
          : PriceLabel.fromJson(json['mrp'] as Map<String, dynamic>),
      json['ptr'] == null
          ? null
          : PriceLabel.fromJson(json['ptr'] as Map<String, dynamic>),
      json['nrv'] == null
          ? null
          : PriceLabel.fromJson(json['nrv'] as Map<String, dynamic>),
      json['pts'] == null
          ? null
          : PriceLabel.fromJson(json['pts'] as Map<String, dynamic>),
      json['beat_edit_action'] as int?,
      json['onboard_action'] as int?,
      json['near_by_stores_limit'] as int?,
      json['near_by_stores_radius'] as int?,
      json['min_accuracy_location_update'] as int?,
      json['min_time_location_update'] as int?,
      json['min_distance_location_update'] as int?,
      json['distributor_selection_confirmation'] as bool?,
      json['allow_multiple_beats'] as bool?,
      json['allow_multi_line_items'] as bool?,
      json['auto_apply_schemes'] as bool?,
      json['distributor_outlet_mapping_flag'] as bool?,
    );

Map<String, dynamic> _$UserSettingsToJson(UserSettings instance) =>
    <String, dynamic>{
      'file': instance.file,
      'currency': instance.currency,
      'currency_symbol': instance.currencySymbol,
      'fy_date': instance.fyDate,
      'otp_flag': instance.otpFlag,
      'dial_code': instance.dialCode,
      'time_zone': instance.timeZone,
      'image_name': instance.imageName,
      'welcome_msg': instance.welcomeMsg,
      'company_name': instance.companyName,
      'country_code': instance.countryCode,
      'gps_accuracy': instance.gpsAccuracy,
      'is_gps_check': instance.isGpsCheck,
      'branding_color': instance.brandingColor,
      'is_otp_allowed': instance.isOtpAllowed,
      'max_cart_value': instance.maxCartValue,
      'min_cart_value': instance.minCartValue,
      'near_by_radius': instance.nearByRadius,
      'time_zone_name': instance.timeZoneName,
      'geo_fence_radius': instance.geoFenceRadius,
      'onboard_otp_flag': instance.onboardOtpFlag,
      'no_order_reason_flag': instance.noOrderReasonFlag,
      'salesman_hotline_msg': instance.salesmanHotlineMsg,
      'contact_number_length': instance.contactNumberLength,
      'order_confirmation_msg': instance.orderConfirmationMsg,
      'default_distributor_role': instance.defaultDistributorRole,
      'default_distributor_group': instance.defaultDistributorGroup,
      'onboard_alternate_otp_flag': instance.onboardAlternateOtpFlag,
      'mrp': instance.mrp,
      'ptr': instance.ptr,
      'nrv': instance.nrv,
      'pts': instance.pts,
      'beat_edit_action': instance.beatEditAction,
      'onboard_action': instance.onBoardAction,
      'near_by_stores_limit': instance.near_by_stores_limit,
      'near_by_stores_radius': instance.near_by_stores_radius,
      'min_accuracy_location_update': instance.min_accuracy_location_update,
      'min_time_location_update': instance.min_time_location_update,
      'min_distance_location_update': instance.min_distance_location_update,
      'distributor_selection_confirmation':
          instance.distributor_selection_confirmation,
      'allow_multiple_beats': instance.allow_multiple_beats,
      'allow_multi_line_items': instance.allow_multi_line_items,
      'auto_apply_schemes': instance.auto_apply_schemes,
      'distributor_outlet_mapping_flag':
          instance.distributor_outlet_mapping_flag,
    };

class UserSettings {
  String? file;
  String? temp;
  String? fyMonth;
  String? fyDate;
  String? currency;
  bool? otpFlag;
  String? dialCode;
  String? timeZone;
  String? imageName;
  String? welcomeMsg;
  String? companyName;
  String? countryCode;
  String? gpsAccuracy;
  bool? isGpsCheck;
  String? wHATSAPPTOKEN;
  String? brandingColor;
  bool? isOtpAllowed;
  int? maxCartValue;
  int? minCartValue;
  int? nearByRadius;
  int? onboardAction;
  String? timeZoneName;
  bool? whatsappOpted;
  String? currencySymbol;
  int? onboardProcess;
  String? attendanceQuery;
  int? beatEditAction;
  String? geoFenceRadius;
  bool? onboardOtpFlag;
  bool? ownMetaAccount;
  int? beatEditProcess;
  bool? autoApplySchemes;
  int? wHATSAPPACCOUNTID;
  int? defaultBusinessId;
  String? kPIAGGREGATIONTYPE;
  bool? allowMultipleBeats;
  bool? canDisableTemplate;
  int? nearByStoresLimit;
  bool? noOrderReasonFlag;
  String? salesmanHotlineMsg;
  int? contactNumberLength;
  int? nearByStoresRadius;
  bool? allowMultiLineItems;
  String? orderConfirmationMsg;
  int? defaultPhoneNumberId;
  int? defaultDistributorRole;
  int? defaultDistributorGroup;
  int? wHATSAPPREGISTEREDNUMBER;
  bool? onboardAlternateOtpFlag;
  bool? distributorOutletMappingFlag;
  String? customReportLastExecutedTime;
  bool? distributorSelectionConfirmation;

  UserSettings(
      {this.file,
      this.temp,
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
      this.wHATSAPPTOKEN,
      this.brandingColor,
      this.isOtpAllowed,
      this.maxCartValue,
      this.minCartValue,
      this.nearByRadius,
      this.onboardAction,
      this.timeZoneName,
      this.whatsappOpted,
      this.currencySymbol,
      this.onboardProcess,
      this.attendanceQuery,
      this.beatEditAction,
      this.geoFenceRadius,
      this.onboardOtpFlag,
      this.ownMetaAccount,
      this.beatEditProcess,
      this.autoApplySchemes,
      this.wHATSAPPACCOUNTID,
      this.defaultBusinessId,
      this.kPIAGGREGATIONTYPE,
      this.allowMultipleBeats,
      this.canDisableTemplate,
      this.nearByStoresLimit,
      this.noOrderReasonFlag,
      this.salesmanHotlineMsg,
      this.contactNumberLength,
      this.nearByStoresRadius,
      this.allowMultiLineItems,
      this.orderConfirmationMsg,
      this.defaultPhoneNumberId,
      this.defaultDistributorRole,
      this.defaultDistributorGroup,
      this.wHATSAPPREGISTEREDNUMBER,
      this.onboardAlternateOtpFlag,
      this.distributorOutletMappingFlag,
      this.customReportLastExecutedTime,
      this.distributorSelectionConfirmation});

  UserSettings.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    temp = json['temp'];
    fyMonth = json['fyMonth'];
    fyDate = json['fy_date'];
    currency = json['currency'];
    otpFlag = json['otp_flag'];
    dialCode = json['dial_code'];
    timeZone = json['time_zone'];
    imageName = json['image_name'];
    welcomeMsg = json['welcome_msg'];
    companyName = json['company_name'];
    countryCode = json['country_code'];
    gpsAccuracy = json['gps_accuracy'];
    isGpsCheck = json['is_gps_check'];
    wHATSAPPTOKEN = json['WHATSAPP_TOKEN'];
    brandingColor = json['branding_color'];
    isOtpAllowed = json['is_otp_allowed'];
    maxCartValue = json['max_cart_value'];
    minCartValue = json['min_cart_value'];
    nearByRadius = json['near_by_radius'];
    onboardAction = json['onboard_action'];
    timeZoneName = json['time_zone_name'];
    whatsappOpted = json['whatsapp_opted'];
    currencySymbol = json['currency_symbol'];
    onboardProcess = json['onboard_process'];
    attendanceQuery = json['attendance_query'];
    beatEditAction = json['beat_edit_action'];
    geoFenceRadius = json['geo_fence_radius'];
    onboardOtpFlag = json['onboard_otp_flag'];
    ownMetaAccount = json['own_meta_account'];
    beatEditProcess = json['beat_edit_process'];
    autoApplySchemes = json['auto_apply_schemes'];
    wHATSAPPACCOUNTID = json['WHATSAPP_ACCOUNT_ID'];
    defaultBusinessId = json['default_business_id'];
    kPIAGGREGATIONTYPE = json['KPI_AGGREGATION_TYPE'];
    allowMultipleBeats = json['allow_multiple_beats'];
    canDisableTemplate = json['can_disable_template'];
    nearByStoresLimit = json['near_by_stores_limit'];
    noOrderReasonFlag = json['no_order_reason_flag'];
    salesmanHotlineMsg = json['salesman_hotline_msg'];
    contactNumberLength = json['contact_number_length'];
    nearByStoresRadius = json['near_by_stores_radius'];
    allowMultiLineItems = json['allow_multi_line_items'];
    orderConfirmationMsg = json['order_confirmation_msg'];
    defaultPhoneNumberId = json['default_phone_number_id'];
    defaultDistributorRole = json['default_distributor_role'];
    defaultDistributorGroup = json['default_distributor_group'];
    wHATSAPPREGISTEREDNUMBER = json['WHATSAPP_REGISTERED_NUMBER'];
    onboardAlternateOtpFlag = json['onboard_alternate_otp_flag'];
    distributorOutletMappingFlag = json['distributor_outlet_mapping_flag'];
    customReportLastExecutedTime = json['custom_report_last_executed_time'];
    distributorSelectionConfirmation =
        json['distributor_selection_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['file'] = this.file;
    data['temp'] = this.temp;
    data['fyMonth'] = this.fyMonth;
    data['fy_date'] = this.fyDate;
    data['currency'] = this.currency;
    data['otp_flag'] = this.otpFlag;
    data['dial_code'] = this.dialCode;
    data['time_zone'] = this.timeZone;
    data['image_name'] = this.imageName;
    data['welcome_msg'] = this.welcomeMsg;
    data['company_name'] = this.companyName;
    data['country_code'] = this.countryCode;
    data['gps_accuracy'] = this.gpsAccuracy;
    data['is_gps_check'] = this.isGpsCheck;
    data['WHATSAPP_TOKEN'] = this.wHATSAPPTOKEN;
    data['branding_color'] = this.brandingColor;
    data['is_otp_allowed'] = this.isOtpAllowed;
    data['max_cart_value'] = this.maxCartValue;
    data['min_cart_value'] = this.minCartValue;
    data['near_by_radius'] = this.nearByRadius;
    data['onboard_action'] = this.onboardAction;
    data['time_zone_name'] = this.timeZoneName;
    data['whatsapp_opted'] = this.whatsappOpted;
    data['currency_symbol'] = this.currencySymbol;
    data['onboard_process'] = this.onboardProcess;
    data['attendance_query'] = this.attendanceQuery;
    data['beat_edit_action'] = this.beatEditAction;
    data['geo_fence_radius'] = this.geoFenceRadius;
    data['onboard_otp_flag'] = this.onboardOtpFlag;
    data['own_meta_account'] = this.ownMetaAccount;
    data['beat_edit_process'] = this.beatEditProcess;
    data['auto_apply_schemes'] = this.autoApplySchemes;
    data['WHATSAPP_ACCOUNT_ID'] = this.wHATSAPPACCOUNTID;
    data['default_business_id'] = this.defaultBusinessId;
    data['KPI_AGGREGATION_TYPE'] = this.kPIAGGREGATIONTYPE;
    data['allow_multiple_beats'] = this.allowMultipleBeats;
    data['can_disable_template'] = this.canDisableTemplate;
    data['near_by_stores_limit'] = this.nearByStoresLimit;
    data['no_order_reason_flag'] = this.noOrderReasonFlag;
    data['salesman_hotline_msg'] = this.salesmanHotlineMsg;
    data['contact_number_length'] = this.contactNumberLength;
    data['near_by_stores_radius'] = this.nearByStoresRadius;
    data['allow_multi_line_items'] = this.allowMultiLineItems;
    data['order_confirmation_msg'] = this.orderConfirmationMsg;
    data['default_phone_number_id'] = this.defaultPhoneNumberId;
    data['default_distributor_role'] = this.defaultDistributorRole;
    data['default_distributor_group'] = this.defaultDistributorGroup;
    data['WHATSAPP_REGISTERED_NUMBER'] = this.wHATSAPPREGISTEREDNUMBER;
    data['onboard_alternate_otp_flag'] = this.onboardAlternateOtpFlag;
    data['distributor_outlet_mapping_flag'] = this.distributorOutletMappingFlag;
    data['custom_report_last_executed_time'] =
        this.customReportLastExecutedTime;
    data['distributor_selection_confirmation'] =
        this.distributorSelectionConfirmation;
    return data;
  }
}

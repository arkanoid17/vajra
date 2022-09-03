import 'package:json_annotation/json_annotation.dart';

part 'country_code.g.dart';


@JsonSerializable()
class CountryCode {

  CountryCode(this.name, this.dialCode,this.code);

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'dial_code')
  String dialCode;

  @JsonKey(name: 'code')
  String code;

  getName() {
    return name;
  }

  setName(var name) {
    this.name = name;
  }

  getDialCode() {
    return dialCode;
  }

  setDialCode(var dialCode) {
    this.dialCode = dialCode;
  }

  getCode() {
    return code;
  }

  setCode(var code) {
    this.code = code;
  }

  factory CountryCode.fromJson(Map<String, dynamic> json) => _$CountryCodeFromJson(json);

  Map<String, dynamic> toJson() => _$CountryCodeToJson(this);
}

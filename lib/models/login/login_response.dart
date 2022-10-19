import 'package:json_annotation/json_annotation.dart';

import 'employee_data.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse{

  LoginResponse(this.status, this.data,this.message);

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'data')
  EmployeeData data;

  @JsonKey(name: 'message')
  String? message;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
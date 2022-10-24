import 'package:json_annotation/json_annotation.dart';

part 'schemes.g.dart';

@JsonSerializable()
class Schemes{
  @JsonKey(name: 'scope')
  String? scope;
  @JsonKey(name: 'scheme')
  int? scheme;
  @JsonKey(name: 'status')
  bool? status;

  Schemes(this.scope, this.scheme, this.status);

  factory Schemes.fromJson(Map<String, dynamic> json) => _$SchemesFromJson(json);

  Map<String, dynamic> toJson() => _$SchemesToJson(this);
}
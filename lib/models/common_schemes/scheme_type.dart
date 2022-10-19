import 'package:json_annotation/json_annotation.dart';
part 'scheme_type.g.dart';

@JsonSerializable()
class SchemeType{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;

  SchemeType(this.id, this.name, this.description);

  factory SchemeType.fromJson(Map<String, dynamic> json) => _$SchemeTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SchemeTypeToJson(this);
}
import 'package:json_annotation/json_annotation.dart';

part 'field.g.dart';

@JsonSerializable()
class Field{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'field_name')
  String? fieldName;

  @JsonKey(name: 'field_type')
  String? fieldType;

  @JsonKey(name: 'default_value')
  String? defaultValue;

  @JsonKey(name: 'required')
  bool? required;

  @JsonKey(name: 'meta')
  Object? meta;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'form')
  int? form;

  Field(this.id, this.fieldName, this.fieldType, this.defaultValue,
      this.required, this.meta, this.createdAt, this.updatedAt, this.form);

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);
}
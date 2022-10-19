import 'package:json_annotation/json_annotation.dart';

import 'field.dart';

part 'form.g.dart';

@JsonSerializable()
class Form{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'fields')
  List<Field>? fields;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  Form(this.id, this.fields, this.name, this.description, this.createdAt,
      this.updatedAt);

  factory Form.fromJson(Map<String, dynamic> json) => _$FormFromJson(json);

  Map<String, dynamic> toJson() => _$FormToJson(this);

}
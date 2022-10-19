import 'package:json_annotation/json_annotation.dart';

part 'submitted_by.g.dart';

@JsonSerializable()
class SubmittedBy{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'user_id')
  String? userId;

  @JsonKey(name: 'name')
  String? name;

  SubmittedBy(this.id, this.userId, this.name);

  factory SubmittedBy.fromJson(Map<String, dynamic> json) => _$SubmittedByFromJson(json);

  Map<String, dynamic> toJson() => _$SubmittedByToJson(this);
}
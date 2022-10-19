import 'package:json_annotation/json_annotation.dart';
part 'parent.g.dart';


@JsonSerializable()
class Parent{
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'status')
  bool? status;

  Parent(this.id, this.name, this.status);

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);

  Map<String?, dynamic> toJson() => _$ParentToJson(this);
}
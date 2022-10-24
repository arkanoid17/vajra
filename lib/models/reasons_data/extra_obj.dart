import 'package:json_annotation/json_annotation.dart';
part 'extra_obj.g.dart';

@JsonSerializable()
class ExtraObj{
  ExtraObj();

  factory ExtraObj.fromJson(Map<String, dynamic> json) => _$ExtraObjFromJson(json);

  Map<String, dynamic> toJson() => _$ExtraObjToJson(this);
}
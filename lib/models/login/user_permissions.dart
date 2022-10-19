import 'package:json_annotation/json_annotation.dart';
part 'user_permissions.g.dart';

@JsonSerializable()
class UserPermissions{

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'content_type')
  String? contentType;

  @JsonKey(name: 'name')
  String? name;
  
  @JsonKey(name: 'codename')
  String? codeName;

  UserPermissions(this.id, this.contentType, this.name, this.codeName);

  factory UserPermissions.fromJson(Map<String, dynamic> json) => _$UserPermissionsFromJson(json);

  Map<String, dynamic> toJson() => _$UserPermissionsToJson(this);
}
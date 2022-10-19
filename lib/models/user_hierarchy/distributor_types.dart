
import 'package:json_annotation/json_annotation.dart';
part 'distributor_types.g.dart';


@JsonSerializable()
class DistributorTypes{

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'code')
  String? code;

  @JsonKey(name: 'status')
  bool? status;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'created_by')
  int? createdBy;

  @JsonKey(name: 'updated_by')
  int? updatedBy;


  DistributorTypes(this.id, this.name, this.description, this.code, this.status,
      this.createdAt, this.updatedAt, this.createdBy, this.updatedBy);


  factory DistributorTypes.fromJson(Map<String, dynamic> json) => _$DistributorTypesFromJson(json);

  Map<String?, dynamic> toJson() => _$DistributorTypesToJson(this);


}


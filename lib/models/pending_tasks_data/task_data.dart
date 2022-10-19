import 'package:json_annotation/json_annotation.dart';

part 'task_data.g.dart';

@JsonSerializable()
class TaskData{
  @JsonKey(name: 'remarks')
  String? remarks;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'invoice_no')
  String? invoiceNo;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  TaskData(this.remarks, this.imageUrl, this.createdAt, this.invoiceNo,
      this.updatedAt);

  factory TaskData.fromJson(Map<String, dynamic> json) => _$TaskDataFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDataToJson(this);
}
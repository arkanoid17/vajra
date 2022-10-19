// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskData _$TaskDataFromJson(Map<String, dynamic> json) => TaskData(
      json['remarks'] as String?,
      json['image_url'] as String?,
      json['created_at'] as String?,
      json['invoice_no'] as String?,
      json['updated_at'] as String?,
    );

Map<String, dynamic> _$TaskDataToJson(TaskData instance) => <String, dynamic>{
      'remarks': instance.remarks,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt,
      'invoice_no': instance.invoiceNo,
      'updated_at': instance.updatedAt,
    };

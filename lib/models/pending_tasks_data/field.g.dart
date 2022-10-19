// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      json['id'] as int?,
      json['field_name'] as String?,
      json['field_type'] as String?,
      json['default_value'] as String?,
      json['required'] as bool?,
      json['meta'],
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['form'] as int?,
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'id': instance.id,
      'field_name': instance.fieldName,
      'field_type': instance.fieldType,
      'default_value': instance.defaultValue,
      'required': instance.required,
      'meta': instance.meta,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'form': instance.form,
    };

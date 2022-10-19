// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page _$PageFromJson(Map<String, dynamic> json) => Page(
      json['current_page'] as int?,
      json['next_page'] as int?,
      json['prev_page'] as String?,
      json['total_pages'] as int?,
      json['page_size'] as int?,
      json['count'] as int?,
    );

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'current_page': instance.currentPage,
      'next_page': instance.nextPage,
      'prev_page': instance.prevPage,
      'total_pages': instance.totalPages,
      'page_size': instance.pageSize,
      'count': instance.count,
    };

import 'package:json_annotation/json_annotation.dart';
part 'pages.g.dart';

@JsonSerializable()
class Page{
  @JsonKey(name: 'current_page')
  int? currentPage;

  @JsonKey(name: 'next_page')
  int? nextPage;

  @JsonKey(name: 'prev_page')
  String? prevPage;

  @JsonKey(name: 'total_pages')
  int? totalPages;

  @JsonKey(name: 'page_size')
  int? pageSize;

  @JsonKey(name: 'count')
  int? count;

  Page(this.currentPage, this.nextPage, this.prevPage, this.totalPages,
      this.pageSize, this.count);

  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);

  Map<String, dynamic> toJson() => _$PageToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/links/links.dart';
import 'package:vajra/models/pages/pages.dart';
import 'package:vajra/models/reasons_data/reasons.dart';

part 'reasons_response.g.dart';

@JsonSerializable()
class ReasonsResponse{
  @JsonKey(name: 'page')
  Page? page;
  @JsonKey(name: 'links')
  Link? links;
  @JsonKey(name: 'results')
  List<Reasons>? results;

  ReasonsResponse(this.page, this.links, this.results);

  factory ReasonsResponse.fromJson(Map<String, dynamic> json) => _$ReasonsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReasonsResponseToJson(this);
}
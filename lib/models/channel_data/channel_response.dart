import 'package:json_annotation/json_annotation.dart';

import '../links/links.dart';
import '../pages/pages.dart';
import 'channel_obj.dart';
part 'channel_response.g.dart';
@JsonSerializable()
class ChannelResponse{
  @JsonKey(name: 'page')
  Page? page;
  @JsonKey(name: 'links')
  Link? links;
  @JsonKey(name: 'results')
  List<ChannelObj>? results;

  ChannelResponse(this.page, this.links, this.results);

  factory ChannelResponse.fromJson(Map<String, dynamic> json) => _$ChannelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelResponseToJson(this);
}
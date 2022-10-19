import 'package:json_annotation/json_annotation.dart';
import 'package:vajra/models/place_data/places.dart';

import '../links/links.dart';
import '../pages/pages.dart';

part 'place_response.g.dart';

@JsonSerializable()
class PlaceResponse{
  @JsonKey(name: 'page')
  Page? page;
  @JsonKey(name: 'links')
  Link? links;
  @JsonKey(name: 'results')
  List<Places>? places;

  PlaceResponse(this.page, this.links, this.places);

  factory PlaceResponse.fromJson(Map<String, dynamic> json) => _$PlaceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceResponseToJson(this);

}
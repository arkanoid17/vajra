import 'package:json_annotation/json_annotation.dart';
part 'links.g.dart';

@JsonSerializable()
class Link{
  @JsonKey(name: 'next')
  String? next;

  @JsonKey(name: 'previous')
  String? previous;

  Link(this.next, this.previous);

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
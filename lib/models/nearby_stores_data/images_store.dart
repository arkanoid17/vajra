import 'package:json_annotation/json_annotation.dart';
part 'images_store.g.dart';

@JsonSerializable()
class ImagesStore{
  @JsonKey(name: 'outer_image')
  String? outerImage;
  @JsonKey(name: 'inner_image')
  String? innerImage;

  ImagesStore(this.outerImage, this.innerImage);

  factory ImagesStore.fromJson(Map<String, dynamic> json) => _$ImagesStoreFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesStoreToJson(this);
}
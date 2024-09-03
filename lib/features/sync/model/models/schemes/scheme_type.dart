import 'package:hive/hive.dart';
part 'scheme_type.g.dart';

@HiveType(typeId: 22, adapterName: 'SchemeTypeAdapter')
class SchemeType {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? description;

  SchemeType({this.id, this.name, this.description});

  SchemeType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}

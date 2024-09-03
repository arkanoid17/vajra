import 'package:hive/hive.dart';

part 'store_schemes.g.dart';

@HiveType(typeId: 17, adapterName: 'StoreSchemesAdapter')
class StoreSchemes {
  @HiveField(0)
  String? scope;

  @HiveField(1)
  int? scheme;

  @HiveField(2)
  bool? status;

  StoreSchemes({this.scope, this.scheme, this.status});

  StoreSchemes.fromJson(Map<String, dynamic> json) {
    scope = json['scope'];
    scheme = json['scheme'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['scope'] = this.scope;
    data['scheme'] = this.scheme;
    data['status'] = this.status;
    return data;
  }
}

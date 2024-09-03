import 'package:hive/hive.dart';

part 'store_pricings.g.dart';

@HiveType(typeId: 18, adapterName: 'StorePricingsAdapter')
class StorePricings {
  @HiveField(0)
  String? scope;

  @HiveField(1)
  int? pricingList;

  @HiveField(2)
  bool? status;

  StorePricings({this.scope, this.pricingList, this.status});

  StorePricings.fromJson(Map<String, dynamic> json) {
    scope = json['scope'];
    pricingList = json['pricing_list'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['scope'] = this.scope;
    data['pricing_list'] = this.pricingList;
    data['status'] = this.status;
    return data;
  }
}

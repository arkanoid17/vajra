import 'package:hive/hive.dart';

part 'stores_meta_data.g.dart';

@HiveType(typeId: 23, adapterName: 'StoreMetaDataAdapter')
class StoreMetaData {
  @HiveField(0)
  String? gstn;

  @HiveField(1)
  String? address;

  @HiveField(2)
  String? license;

  @HiveField(3)
  String? remarks;

  @HiveField(4)
  int? attempts;

  @HiveField(5)
  String? innerImageUrl;

  @HiveField(6)
  String? outerImageUrl;

  StoreMetaData(
      {this.gstn,
      this.address,
      this.license,
      this.remarks,
      this.attempts,
      this.innerImageUrl,
      this.outerImageUrl});

  StoreMetaData.fromJson(Map<String, dynamic> json) {
    gstn = json['gstn'];
    address = json['address'];
    license = json['license'];
    remarks = json['remarks'];
    attempts = json['attempts'];
    innerImageUrl = json['inner_image_url'];
    outerImageUrl = json['outer_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['gstn'] = this.gstn;
    data['address'] = this.address;
    data['license'] = this.license;
    data['remarks'] = this.remarks;
    data['attempts'] = this.attempts;
    data['inner_image_url'] = this.innerImageUrl;
    data['outer_image_url'] = this.outerImageUrl;
    return data;
  }
}

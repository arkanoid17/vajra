import 'package:hive/hive.dart';

part 'store_colours.g.dart';

@HiveType(typeId: 20, adapterName: 'StoreColoursAdapter')
class StoreColours {
  @HiveField(0)
  int? colour;

  @HiveField(1)
  int? beat;

  @HiveField(2)
  int? salesTerritory;

  @HiveField(3)
  String? visitDate;

  @HiveField(4)
  int? bill;

  @HiveField(5)
  int? noBill;

  StoreColours(
      {this.colour,
      this.beat,
      this.salesTerritory,
      this.visitDate,
      this.bill,
      this.noBill});

  StoreColours.fromJson(Map<String, dynamic> json) {
    colour = json['colour'];
    beat = json['beat'];
    salesTerritory = json['sales_territory'];
    visitDate = json['visit_date'];
    bill = json['bill'];
    noBill = json['no_bill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['colour'] = this.colour;
    data['beat'] = this.beat;
    data['sales_territory'] = this.salesTerritory;
    data['visit_date'] = this.visitDate;
    data['bill'] = this.bill;
    data['no_bill'] = this.noBill;
    return data;
  }
}

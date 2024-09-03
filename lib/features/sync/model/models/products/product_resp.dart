import 'package:vajra_test/features/sync/model/models/products/products.dart';

class ProductResp {
  String? status;
  List<Products>? data;
  bool? isDeletePrevious;
  List<int>? deleteProductIds;
  String? lastUpdate;

  ProductResp(
      {this.status,
      this.data,
      this.isDeletePrevious,
      this.deleteProductIds,
      this.lastUpdate});

  ProductResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Products>[];
      json['data'].forEach((v) {
        data!.add(Products.fromJson(v));
      });
    }
    isDeletePrevious = json['isDeletePrevious'];
    if (json['deleteProductIds'] != null) {
      deleteProductIds = <int>[];
      json['deleteProductIds'].forEach((v) {
        deleteProductIds!.add(v);
      });
    }
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['isDeletePrevious'] = this.isDeletePrevious;
    if (this.deleteProductIds != null) {
      data['deleteProductIds'] = this.deleteProductIds!.map((v) => v).toList();
    }
    data['last_update'] = this.lastUpdate;
    return data;
  }
}

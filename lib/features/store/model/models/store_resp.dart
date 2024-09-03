import 'package:vajra_test/features/store/model/models/store.dart';

class StoreResp {
  String? status;
  String? message;
  List<Store>? data;
  String? lastUpdate;
  int? removeOldData;

  StoreResp(
      {this.status,
      this.message,
      this.data,
      this.lastUpdate,
      this.removeOldData});

  StoreResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Store>[];
      json['data'].forEach((v) {
        data!.add(Store.fromJson(v));
      });
    }
    lastUpdate = json['last_update'];
    removeOldData = json['removeOldData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['last_update'] = this.lastUpdate;
    data['removeOldData'] = this.removeOldData;
    return data;
  }
}

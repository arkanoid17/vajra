import 'package:vajra_test/cores/model/user/user_data.dart';

class AuthResp {
  String? status;
  UserData? data;

  AuthResp({this.status, this.data});

  AuthResp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

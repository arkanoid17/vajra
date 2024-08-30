class UserPermissions {
  int? id;
  String? contentType;
  String? name;
  String? codename;

  UserPermissions({this.id, this.contentType, this.name, this.codename});

  UserPermissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentType = json['content_type'];
    name = json['name'];
    codename = json['codename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['content_type'] = this.contentType;
    data['name'] = this.name;
    data['codename'] = this.codename;
    return data;
  }
}

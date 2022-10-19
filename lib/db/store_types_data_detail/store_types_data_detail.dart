class StoreTypesDataDetailFields{
  static const String id = '_id';
  static const String name = 'name';
}
class StoreTypesDataDetail{
  int? id;
  String? name;

  StoreTypesDataDetail(this.id, this.name);

  Map<String,Object?> toJson() =>{
    StoreTypesDataDetailFields.id:id,
    StoreTypesDataDetailFields.name:name
  };
}
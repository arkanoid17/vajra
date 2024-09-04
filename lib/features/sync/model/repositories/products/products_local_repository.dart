import 'package:hive/hive.dart';
import 'package:vajra_test/features/sync/model/models/products/products.dart';
import 'package:vajra_test/init_dependencies.dart';

class ProductsLocalRepository {
  Future<bool> addProducts(List<Products> products, int salesmanId) async {
    Map<String, Products> map = {};

    Box<Products> box = serviceLocator();

    await box.clear();

    for (int i = 0; i < products.length; i++) {
      products[i].salesmanId = salesmanId;
      map[i.toString()] = products[i];
    }

    await box.putAll(map);

    return true;
  }
}

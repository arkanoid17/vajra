import 'package:hive/hive.dart';
import 'package:vajra_test/features/sync/model/models/products/products.dart';
import 'package:vajra_test/init_dependencies.dart';

class ProductsLocalRepository {
  void addProducts(List<Products> products, int salesmanId) async {
    Map<String, Products> map = {};

    Box<Products> box = serviceLocator();

    final val = await box.clear();

    for (int i = 0; i < products.length; i++) {
      products[i].salesmanId = salesmanId;
      map[i.toString()] = products[i];
    }

    box.putAll(map);
  }
}

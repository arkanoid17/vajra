import 'package:hive/hive.dart';
import 'package:vajra_test/features/sync/model/models/schemes/schemes.dart';
import 'package:vajra_test/init_dependencies.dart';

class SchemesLocalRepository {
  Box<Schemes> schemesBox = serviceLocator();

  void addAllSchemes(List<Schemes> schemes, int salesmanId) async {
    final val = await schemesBox.clear();

    Map<String, Schemes> map = Map();

    for (int i = 0; i < schemes.length; i++) {
      map[i.toString()] = schemes[i];
    }

    schemesBox.clear();
    schemesBox.putAll(map);
  }
}

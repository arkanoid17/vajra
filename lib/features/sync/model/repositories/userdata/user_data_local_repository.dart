import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:vajra_test/cores/model/user/user_data.dart';
import 'package:vajra_test/init_dependencies.dart';

class UserDataLocalRepository {
  void addUser(UserData user) {
    serviceLocator<Box>().delete('user');
    serviceLocator<Box>().put('user', jsonEncode(user.toJson()));
  }

  UserData getUser() {
    String user = serviceLocator<Box>().get('user');
    return UserData.fromJson(jsonDecode(user));
  }
}

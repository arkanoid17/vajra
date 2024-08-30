import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:vajra_test/cores/constants/server_constants.dart';
import 'package:vajra_test/cores/model/user/user_data.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';

class UserDataRemoteRepository {
  Future<Either<String, UserData>> getUserData() async {
    try {
      final res = await http.get(
        Uri.parse(
          '${ServerConstants.baseUrl}${ServerConstants.userDataUrl}',
        ),
        headers: headers,
      );

      final resMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode == ServerConstants.successStatusCode) {
        return right(UserData.fromJson(resMap));
      }
      return left('error');
    } catch (e) {
      return left(e.toString());
    }
  }
}

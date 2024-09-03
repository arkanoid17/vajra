import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:vajra_test/cores/constants/server_constants.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/features/sync/model/models/userhierarchy/user_hierarchy.dart';
import 'package:vajra_test/init_dependencies.dart';

class UserHierarchyRemoteRepository {
  Future<Either<String, List<UserHierarchy>>> getUserHierarchy(
      bool isExternal) async {
    try {
      final res = await http.get(
        Uri.parse(
          '${ServerConstants.baseUrl}${ServerConstants.userHierachyUrl}',
        ).replace(
          queryParameters: {'is_external': isExternal.toString()},
        ),
        headers: headers,
      );

      final resMap = jsonDecode(res.body) as List<dynamic>;

      if (res.statusCode == ServerConstants.successStatusCode) {
        var listUsers = resMap
            .map(
              (e) => UserHierarchy.fromJson(e),
            )
            .toList();

        return right(
          listUsers,
        );
      }

      return left('error');
    } catch (e) {
      return left(e.toString());
    }
  }
}

import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:vajra_test/cores/constants/server_constants.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/features/sync/model/models/schemes/schemes.dart';

class SchemesRemoteRepository {
  Future<Either<String, List<Schemes>>> getAllSchemes(bool paging) async {
    try {
      final res = await http.get(
        Uri.parse('${ServerConstants.baseUrl}${ServerConstants.schemesUrl}')
            .replace(
          queryParameters: {
            'no_page': paging.toString(),
          },
        ),
        headers: headers,
      );

      final resMap = jsonDecode(res.body) as List<dynamic>;

      if (res.statusCode == ServerConstants.successStatusCode) {
        List<Schemes> schemes = resMap.map((e) => Schemes.fromJson(e)).toList();

        return right(schemes);
      }

      return left('error');
    } catch (e) {
      return left(e.toString());
    }
  }
}

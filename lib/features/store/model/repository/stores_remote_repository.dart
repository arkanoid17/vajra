import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:vajra_test/cores/constants/server_constants.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/features/store/model/models/store_resp.dart';

class StoresRemoteRepository {
  Future<Either<String, StoreResp>> getStores(int salesmanId) async {
    try {
      final res = await http.get(
        Uri.parse('${ServerConstants.baseUrl}${ServerConstants.storesUrl}')
            .replace(
          queryParameters: {
            'salesman_id': salesmanId.toString(),
          },
        ),
        headers: headers,
      );

      final resMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode == ServerConstants.successStatusCode) {
        return right(StoreResp.fromJson(resMap));
      }

      return left('error');
    } catch (e) {
      return left(e.toString());
    }
  }
}

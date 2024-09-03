import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:vajra_test/cores/constants/server_constants.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/features/sync/model/models/products/product_resp.dart';

class ProductsRemoteRepository {
  Future<Either<String, ProductResp>> getProducts(int salesmanId) async {
    try {
      final res = await http.get(
        Uri.parse('${ServerConstants.baseUrl}${ServerConstants.productsUrl}')
            .replace(
          queryParameters: {'salesman_id': salesmanId.toString()},
        ),
        headers: headers,
      );

      final resMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode == ServerConstants.successStatusCode) {
        return right(ProductResp.fromJson(resMap));
      }

      return left('Error fetching products!');
    } catch (e) {
      return left(e.toString());
    }
  }
}

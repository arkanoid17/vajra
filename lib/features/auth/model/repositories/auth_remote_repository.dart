import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/constants/server_constants.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/features/auth/model/models/auth_error.dart';
import 'package:vajra_test/features/auth/model/models/auth_resp.dart';

class AuthRemoteRepository {
  Future<Either<AuthError, AuthResp>> login(
      String company, String number, String password) async {
    try {
      String? deviceId = await getDeviceId();

      Map<String, String> fields = {
        'username': number,
        'password': password,
        'device_id': deviceId ?? '',
      };

      final res = await http.post(
        Uri.parse('${ServerConstants.baseUrl}${ServerConstants.loginUrl}'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'tenant-id': company,
        },
        body: fields,
      );

      final resMap = jsonDecode(res.body) as Map<String, dynamic>;

      if (res.statusCode == 200) {
        if (resMap['status'] == ServerConstants.SUCCESS) {
          return right(AuthResp.fromJson(resMap));
        } else {
          return left(
            AuthError(
              message: resMap['message'],
              status: ServerConstants.ERROR,
            ),
          );
        }
      }

      return left(
        AuthError(
          message: AppStrings.thereWasAnIssueLoggingIn,
          status: ServerConstants.ERROR,
        ),
      );
    } catch (e) {
      return left(
          AuthError(message: e.toString(), status: ServerConstants.ERROR));
    }
  }
}

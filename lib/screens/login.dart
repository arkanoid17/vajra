import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vajra/dialogs/country_code_dialog.dart';
import 'package:vajra/models/country_code/country_code.dart';
import 'package:vajra/models/login/login_response.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/services/APIServices.dart';
import 'package:vajra/utils/app_utils.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _isHidden = true;
  bool _isPressed = false;

  SharedPreferences? prefs;

  String deviceId = '';

  TextEditingController companyController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  List<CountryCode> countryList = [];



  @override
  Widget build(BuildContext context) {
    setState(() {
      codeController.text = "+91";
    });

    if(deviceId==""){
      AppUtils.getDeviceId().then((value) => {
        deviceId = value!,
      });
    }

    if(prefs==null){
      AppUtils.getPrefs().then((value) => {
        setState(() {
          prefs = value;
        })
      });
    }

    return Scaffold(
      backgroundColor: ColorConstants.colorPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        AppStrings.welcomeBack,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        AppStrings.pleaseLoginToContinue,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
              flex: 6,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(75))),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: companyController,
                        decoration: const InputDecoration(
                            isDense: true,
                            prefixIcon: Icon(Icons.store),
                            border: OutlineInputBorder(),
                            labelText: AppStrings.companyName,
                            hintText: AppStrings.companyName),
                      ),
                      const SizedBox(
                        width: 5,
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: codeController,
                                readOnly: true,
                                onTap: () => showCountryCodeSelectionDialog(),
                                decoration: const InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(),
                                    labelText: AppStrings.code,
                                    hintText: AppStrings.code),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 3,
                              child: TextField(
                                controller: numberController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                    isDense: true,
                                    prefixIcon: Icon(Icons.phone_android),
                                    border: OutlineInputBorder(),
                                    labelText: AppStrings.number,
                                    hintText: AppStrings.number),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: passwordController,
                        keyboardType: TextInputType.number,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: const Icon(Icons.lock),
                            suffix: InkWell(
                              onTap: () => {
                                setState(() {
                                  _isHidden = !_isHidden;
                                })
                              },
                              child: Icon(_isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            border: const OutlineInputBorder(),
                            labelText: AppStrings.password,
                            hintText: AppStrings.password),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _isPressed
                              ? const CircularProgressIndicator(
                                  color: ColorConstants.colorPrimary,
                                )
                              : Expanded(
                                  child: ElevatedButton(
                                      onPressed: () => {
                                        FocusManager.instance.primaryFocus?.unfocus(),

                                        if (companyController.text
                                                    .toString() !=
                                                '')
                                              {
                                                if (numberController.text
                                                        .toString() !=
                                                    '')
                                                  {
                                                    if (passwordController.text
                                                            .toString() !=
                                                        '')
                                                      {
                                                        setState(() {
                                                          _isPressed =
                                                              !_isPressed;
                                                        }),
                                                        callLogin(
                                                            companyController
                                                                .text
                                                                .toString()
                                                                .trim(),
                                                            codeController.text
                                                                    .toString() +
                                                                numberController
                                                                    .text
                                                                    .toString()
                                                                    .trim(),
                                                            passwordController
                                                                .text
                                                                .toString()
                                                                .trim())
                                                      }
                                                    else
                                                      {
                                                        showErrorMessage(
                                                            AppStrings.pw_empty)
                                                      }
                                                  }
                                                else
                                                  {
                                                    showErrorMessage(
                                                        AppStrings.nmb_empty)
                                                  }
                                              }
                                            else
                                              {
                                                showErrorMessage(
                                                    AppStrings.company_empty)
                                              }
                                          },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                ColorConstants.colorPrimary),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                        ),
                                      ),
                                      child: const Text(AppStrings.login)),
                                )
                        ],
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  showErrorMessage(var message) {
    AppUtils.showMessage( message);
  }

  showCountryCodeSelectionDialog() {
    AppUtils.showBottomDialog(
        context, true, true, Colors.white,CountryCodeDialog(countryList: countryList, codeController: codeController)
    );
  }

  callLogin(String company, String number, String password) async {
    var request = http.MultipartRequest(
        "POST",
        Uri.parse(AppUtils.baseUrl + APIServices.login)
    );
    request.headers.addAll(AppUtils.headers(company, ""));
    request.fields['username'] = number;
    request.fields['password'] = password;
    request.fields['device_id'] = deviceId;


    LoginResponse loginResponse;
    http.Response.fromStream(await request.send())
    .timeout(const Duration(seconds: 10), onTimeout: () {
      throw Exception(TimeoutException(AppStrings.login_error));
    })
    .then((value) => {

      setState((){
        _isPressed = false;
      }),

      //check for status item of response

      if(value.body!=''){
        loginResponse = LoginResponse.fromJson(json.decode(value.body)) ,
        if(loginResponse.status=="OK"){
          saveUserData(loginResponse),
          Navigator.pushReplacementNamed(context, '/dashboard')
        }else{
          // if(loginResponse.message=='device_changed'){
          //   AppUtils.showMessage( AppStrings.deviceChanged)
          // }else if(loginResponse.message=='wrong_credentials'){
          //   AppUtils.showMessage( AppStrings.wrongCredentials)
          // }else{
          //   showErrorMessage(AppStrings.login_error)
          // }

          AppUtils.showMessage( loginResponse.status)
        }

      }else{
        showErrorMessage(AppStrings.login_error)
      }
    })
    .onError((error, stackTrace) => {
      setState((){
        _isPressed = false;
      }),
      showErrorMessage(error.toString()),

    });
  }

  saveUserData(LoginResponse empData) {
    prefs!.setString('token', empData.data.token!=null?empData.data.token!:"");
    prefs!.setString('name', empData.data.name!);
    prefs!.setString('user_id', empData.data.userId!);
    prefs!.setInt('server_id', empData.data.id!);
    prefs!.setBool('is_external', empData.data.isExternal!);
    prefs!.setString('tenant_id', empData.data.tenantId!);
  }






}

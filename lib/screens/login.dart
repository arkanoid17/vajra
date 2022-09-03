import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vajra/dialogs/country_code_dialog.dart';
import 'package:vajra/models/country_code/country_code.dart';
import 'package:vajra/resource_helper/color_constants.dart';
import 'package:vajra/resource_helper/strings.dart';
import 'package:vajra/utils/app_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  bool _isHidden = true;
  bool _isPressed = false;

  var _countryCodeView;

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
    AppUtils.showMessage(context, message);
  }

  showCountryCodeSelectionDialog() {
    if (countryList.isEmpty) {
      setState(() {
        _countryCodeView = getCircularProgress();
      });

      DefaultAssetBundle.of(context)
          .loadString("assets/json/country.json")
          .then((value) => {
        countryList = (json.decode(value) as List)
            .map((i) => CountryCode.fromJson(i))
            .toList(),
        setCountryCodeDialogView()
      });
    } else {
      setCountryCodeDialogView();
    }

    AppUtils.showBottomDialog(
        context, true, false, Colors.white, _countryCodeView);
  }

  getCircularProgress() {
    return  const SizedBox(
      height: 200,
      child:  Center(
        child: CircularProgressIndicator(
          color: ColorConstants.colorPrimary,
        ),
      ),
    );
  }

  setCountryCodeDialogView() {
    setState(() {
      _countryCodeView = CountryCodeDialog(countryList: countryList, codeController: codeController);
    });
  }

  callLogin(String company, String number, String password) {}


}

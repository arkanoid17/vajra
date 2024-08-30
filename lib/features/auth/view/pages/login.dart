import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vajra_test/cores/constants/app_dimens.dart';
import 'package:vajra_test/cores/constants/app_strings.dart';
import 'package:vajra_test/cores/themes/app_palette.dart';
import 'package:vajra_test/cores/utils/app_utils.dart';
import 'package:vajra_test/cores/widgets/custom_text_field.dart';
import 'package:vajra_test/cores/widgets/loader.dart';
import 'package:vajra_test/features/auth/view/widgets/country_code_selector.dart';
import 'package:vajra_test/features/auth/viewmodel/bloc/auth_bloc_bloc.dart';
import 'package:vajra_test/features/home/view/pages/home_page.dart';

class Login extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const Login());

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();

  final companyController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  final numberController = TextEditingController();
  final passwordController = TextEditingController();

  bool ispaswordVisible = false;

  @override
  void initState() {
    context.read<AuthBlocBloc>().add(AuthBlocInitialEvent());
    codeController.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppPalette.primaryColor,
      body: BlocConsumer<AuthBlocBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            showSnackbar(context, state.error.message);
          }
          if (state is AuthSuccessState) {
            context
                .read<AuthBlocBloc>()
                .add(AuthSaveUserDetailsEvent(resp: state.response));
          }
          if (state is AuthUserDetailsSaveSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              HomePage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(AppDimens.screenPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.welcomeBack,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppPalette.whiteColor,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          AppStrings.pleaseLoginToContinue,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppPalette.whiteColor,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: AppPalette.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            CustomTextField(
                              labelText: AppStrings.company,
                              textController: companyController,
                              prefixIcon: const Icon(
                                  Icons.store_mall_directory_outlined),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: CustomTextField(
                                    onTap: showCountryCodeSelector,
                                    labelText: AppStrings.code,
                                    textController: codeController,
                                    isreadOnly: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  flex: 7,
                                  child: CustomTextField(
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    labelText: AppStrings.number,
                                    textController: numberController,
                                    prefixIcon: const Icon(
                                      Icons.phone_outlined,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              keyboardType: TextInputType.number,
                              labelText: AppStrings.password,
                              textController: passwordController,
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.remove_red_eye,
                                ),
                                onPressed: () => setState(() {
                                  ispaswordVisible = !ispaswordVisible;
                                }),
                              ),
                              isObscureText: !ispaswordVisible,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            state is AuthLoadingState
                                ? const Loader()
                                : SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: ElevatedButton(
                                      onPressed: onLoginPressed,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppPalette.primaryColor,
                                      ),
                                      child: const Text(
                                        AppStrings.login,
                                        style: TextStyle(
                                          color: AppPalette.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    companyController.dispose();
    codeController.dispose();
    numberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onCountryCodeSelected(String dialCode) {
    codeController.text = dialCode;
  }

  void showCountryCodeSelector() {
    showBottomDialog(
        context,
        CountryCodeSelector(
          onSelected: onCountryCodeSelected,
        ));
  }

  void onLoginPressed() async {
    if (formkey.currentState!.validate()) {
      context.read<AuthBlocBloc>().add(
            AuthLoginEvent(
              number: codeController.text.trim() + numberController.text.trim(),
              password: passwordController.text.trim(),
              company: companyController.text.trim(),
            ),
          );
    }
  }
}

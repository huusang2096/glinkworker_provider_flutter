import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glinkwok_provider/routes.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/components/custom_default_button.dart';
import 'package:glinkwok_provider/src/components/validations.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

import 'cubit/login_cubit.dart';

class LoginScreen extends CubitWidget<LoginCubit, LoginState> {
  Validations _validations = Validations();
  TextEditingController _phone = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController2 = TextEditingController();

  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'VN');

  static provider() {
    return BlocProvider<LoginCubit>(
      create: (_) => LoginCubit(),
      child: LoginScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.checkSavedCredential();
  }

  @override
  void listener(BuildContext context, LoginState state) {
    super.listener(context, state);
    if (state is LoginSuccessState) {
      navigator.pushNamedAndRemoveUntil(
          AppRoute.homeScreen, (Route<dynamic> route) => false);
    }
    if (state is ShowSavedCredential) {
      final email = state.loginRequest.email ?? '';
      final password = state.loginRequest.password ?? '';
      _emailController.text = email;
      state.isCheckLoginByPhone
          ? _passwordController2.text = password
          : _passwordController.text = password;
      _phone.text = state.loginRequest?.mobile ?? '';
      _phoneNumber = PhoneNumber(isoCode: 'VN', phoneNumber: _phone.text);
    }
  }

  @override
  Widget builder(BuildContext context, LoginState state) {
    return AppProgressHUB(
      inAsyncCall: state.isLoading,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.0, 30.0, 24.0, 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Images.logo.loadImage(),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "welcome_back".tr,
                      style: heading1,
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "slogan".tr,
                      style: body1.apply(color: greyColorText),
                    ),
                    SizedBox(
                      height: 72,
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width - 20.0,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: _buildFormLogin(context, state),
                          ),
                          SizedBox(height: 10),
                          _buildToggleLogin(context, state),
                          SizedBox(height: 24),
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "dont_have_account".tr,
                                  style: textGrey,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                  onTap: () {
                                    navigator.pushNamed(AppRoute.signUpScreen);
                                  },
                                  child: Text(
                                    "sign_up".tr,
                                    style: textStyleActive,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleLogin(BuildContext context, LoginState state) {
    return CustomDefaultButton(
      bgColor: Colors.white,
      text:
          state.isCheckLoginByPhone ? "login_by_email".tr : "login_by_phone".tr,
      textStyle: buttonTextStyle.apply(color: primaryColor),
      press: bloc.toggleLoginByPhone,
    );
  }

  Widget _buildFormLogin(BuildContext context, LoginState state) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              state.isCheckLoginByPhone
                  ? InternationalPhoneNumberInput(
                      selectorConfig: SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
                      onInputChanged: (value) {
                        _phoneNumber = value;
                      },
                      textFieldController: _phone,
                      onInputValidated: (isValidate) {},
                      initialValue: _phoneNumber,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      inputDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        hintText: 'phone'.tr,
                      ),
                    )
                  : TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: _emailController,
                      validator: _validations.validateEmail,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          prefixIcon: Icon(Icons.person, size: 20.0),
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 15.0),
                          hintText: 'email'.tr,
                          hintStyle: body2)),
              SizedBox(
                height: 10,
              ),
              state.isCheckLoginByPhone
                  ? TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController2,
                      validator: _validations.validatePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 20.0,
                        ),
                        contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                        hintText: 'password'.tr,
                        hintStyle: body2,
                      ),
                    )
                  : TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      validator: _validations.validatePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          size: 20.0,
                        ),
                        contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                        hintText: 'password'.tr,
                        hintStyle: body2,
                      ),
                    ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          _buildOptionLogin(context, state),
          SizedBox(
            height: 12,
          ),
          CustomDefaultButton(
            text: "login".tr,
            press: () => bloc.submitLogin(
                email: _emailController.text,
                password: state.isCheckLoginByPhone
                    ? _passwordController2.text
                    : _passwordController.text,
                phoneNumber: _phoneNumber),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionLogin(BuildContext context, LoginState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  bloc.toggleRememberMe();
                },
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  child: state.isCheckSaveAccount
                      ? Icon(
                          Icons.check_box,
                          size: 24.0,
                          color: primaryColor,
                        )
                      : Icon(
                          Icons.check_box_outline_blank,
                          size: 24.0,
                          color: Colors.grey,
                        ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "remember_me".tr,
                style: body2,
              )
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                padding: EdgeInsets.all(0),
                child: Text(
                  "forgot_password".tr,
                  style: textStyleActive,
                ),
                onPressed: bloc.gotToForgot,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

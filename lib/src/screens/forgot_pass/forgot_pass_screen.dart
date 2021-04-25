import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/forgot_pass/cubit/forgot_pass_cubit.dart';
import 'package:glinkwok_provider/src/util/validator.dart';
import 'package:simplest/simplest.dart';

class ForgotPassScreen extends CubitWidget<ForgotPassCubit, ForgotPassState> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  PhoneNumber _phoneNumber = PhoneNumber(isoCode: 'VN');

  static Widget provider() {
    return BlocProvider(
      create: (_) => ForgotPassCubit(),
      child: ForgotPassScreen(),
    );
  }

  @override
  Widget builder(BuildContext context, ForgotPassState state) {
    return Scaffold(
      body: SingleChildScrollView(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 30.0, 24.0, 40.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Images.logo.loadImage(),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "forgot_password".tr,
                  style: heading1,
                ),
                SizedBox(
                  height: 72,
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 20.0,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: _buildFormLogin(context, state),
                    ),
                    SizedBox(height: 10),
                    // Login by phone
                    SizedBox(height: 24),
                    Container(
                      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "already_have_an_account".tr,
                            style: body2,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          GestureDetector(
                            onTap: bloc.gotoLogin,
                            child: Text(
                              "login_here".tr,
                              style: textStyleActive,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      )),
    );
  }

  Widget _buildFormLogin(BuildContext context, ForgotPassState state) {
    Widget _usernameInput = InternationalPhoneNumberInput(
      errorMessage: 'incorrect_phone'.tr,
      selectorConfig:
          SelectorConfig(selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
      onInputChanged: (value) {
        _phoneNumber = value;
      },
      onInputValidated: (isValidate) {},
      initialValue: _phoneNumber,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      inputDecoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        hintText: 'phone'.tr,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _usernameInput,
        SizedBox(
          height: 10,
        ),
        // password
        TextFormField(
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            validator: Validator.validatePassword,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                prefixIcon: Icon(Icons.lock, size: 20.0),
                contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                hintText: 'password'.tr,
                hintStyle: body2)),
        SizedBox(
          height: 10,
        ),
        TextFormField(
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            controller: _confirmPasswordController,
            validator: Validator.validatePassword,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                prefixIcon: Icon(Icons.lock, size: 20.0),
                contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                hintText: 'confirm_password'.tr,
                hintStyle: body2)),
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 56,
          width: double.infinity,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            color: primaryColor,
            child: state.inAsyncCall
                ? SpinKitCircle(
                    color: Colors.white,
                    size: 36,
                  )
                : Text(
                    "request".tr,
                    style: buttonTextStyle,
                  ),
            onPressed: () => state.inAsyncCall
                ? () {}
                : bloc.submit(
                    phoneNumber: _phoneNumber,
                    password: _passwordController.text,
                    confirmPassword: _confirmPasswordController.text,
                  ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glinkwok_provider/routes.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/components/custom_default_button.dart';
import 'package:glinkwok_provider/src/components/validations.dart';
import 'package:glinkwok_provider/src/screens/signup/cubit/signup_cubit.dart';
import 'package:simplest/simplest.dart';

class SignupScreen extends CubitWidget<SignupCubit, SignupState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  List<String> items;
  Validations validations = Validations();

  static provider(BuildContext context) {
    return BlocProvider<SignupCubit>(
      create: (context) => SignupCubit(),
      child: SignupScreen(),
    );
  }

  @override
  Widget builder(BuildContext context, SignupState state) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                child: Theme(
                  data: Theme.of(context).copyWith(primaryColor: Colors.grey),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderSignUp(),
                      _buildFormSignUp(context),
                      // _buildOptionLogin(context),
                      SizedBox(
                        height: 20.0,
                      ),
                      _buildButtonSignUp(context, state),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildFooterSignUp(context),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void listener(BuildContext context, SignupState state) {
    super.listener(context, state);
    if (state is SignupSuccessState) {
      navigator.pushReplacementNamed(AppRoute.loginScreen);
    }
  }

  void submit(BuildContext context) async {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      bloc.submitRegister();
    }
  }

  Widget _buildHeaderSignUp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20.0,
        ),
        Images.logo.loadImage(),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "create_account".tr,
          style: heading1,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "body_text_label_signup".tr,
          maxLines: 2,
          style: textGrey,
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }

  Widget _buildFormSignUp(BuildContext context) {
    items = ["male", "female"];
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: validations.validateEmail,
            onSaved: bloc.updateEmail,
            decoration: InputDecoration(
              hintText: "email_address".tr,
              prefixIcon: Icon(Icons.email),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: validations.validateName,
                  onSaved: bloc.updateFirstName,
                  decoration: InputDecoration(
                    hintText: "first_name".tr,
                    prefixIcon: Icon(Icons.perm_identity),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  validator: validations.validateName,
                  onSaved: bloc.updateLastName,
                  decoration: InputDecoration(
                    hintText: "last_name".tr,
                    prefixIcon: Icon(Icons.perm_identity),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 6.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey),
                borderRadius: BorderRadius.circular(6.0)),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
                isExpanded: true,
                underline: SizedBox(),
                value: bloc.state.registerRequest.gender,
                icon: Icon(Icons.arrow_drop_down),
                items: items.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val.tr),
                  );
                }).toList(),
                onChanged: bloc.selectGender),
          ),
          SizedBox(
            height: 10.0,
          ),
          InternationalPhoneNumberInput(
            errorMessage: 'invalid_phone_number'.tr,
            selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
            onInputChanged: bloc.updatePhoneNumber,
            onInputValidated: (isValidate) {},
            initialValue: PhoneNumber(isoCode: 'VN'),
            autoValidateMode: AutovalidateMode.onUserInteraction,
            inputDecoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintText: 'phone'.tr,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            key: _passwordFieldKey,
            validator: validations.validatePassword,
            keyboardType: TextInputType.text,
            onSaved: bloc.updatePassword,
            obscureText: bloc.state.isPasswordObsecure,
            decoration: InputDecoration(
              hintText: 'enter_your_pass'.tr,
              prefixIcon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () {
                  bloc.touchShowPassword();
                },
                child: Icon(bloc.state.isPasswordObsecure
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            onSaved: bloc.updateConfirmPassword,
            obscureText: bloc.state.isConfirmObsecure,
            validator: (value) {
              if (value != _passwordFieldKey.currentState.value) {
                return "pass_do_not_match".tr;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "confirm_pass".tr,
              prefixIcon: Icon(Icons.lock),
              suffixIcon: GestureDetector(
                onTap: () {
                  bloc.touchShowPasswordAgain();
                },
                child: Icon(bloc.state.isConfirmObsecure
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSignUp(BuildContext context, SignupState state) {
    return CustomDefaultButton(
      isLoading: state.inAsyncCall,
      text: "sign_up".tr,
      press: () {
        submit(context);
      },
    );
  }

  Widget _buildFooterSignUp(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
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
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoute.loginScreen, (route) => false);
            },
            child: Text(
              "login_here".tr,
              style: textStyleActive,
            ),
          ),
        ],
      ),
    );
  }
}

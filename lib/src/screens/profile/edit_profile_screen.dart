import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/components/custom_appbar.dart';
import 'package:glinkwok_provider/src/components/custom_default_button.dart';
import 'package:glinkwok_provider/src/components/validations.dart';
import 'package:glinkwok_provider/src/screens/profile/cubit/profile_cubit.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simplest/simplest.dart';

class EditProfileScreen extends CubitWidget<ProfileCubit, ProfileState> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  Validations _validations = Validations();
  PhoneNumber _phoneNumber = PhoneNumber();

  static provider() {
    return BlocProvider<ProfileCubit>(
      create: (_) => ProfileCubit(),
      child: EditProfileScreen(),
    );
  }

  _initUI(BuildContext context) {
    bloc.getProfile();
  }

  void _handleUpdate(BuildContext context, ProfileState state) {
    final FormState form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      bloc.submitUpdate(
        mobile: _mobileController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
      );
    }
  }

  @override
  void listener(BuildContext context, ProfileState state) {
    super.listener(context, state);
    if (state is GetProfileSuccessState) {
      _firstNameController =
          TextEditingController(text: state.profileResponse?.firstName ?? "");
      _lastNameController =
          TextEditingController(text: state.profileResponse?.lastName ?? "");
      _mobileController =
          TextEditingController(text: state.profileResponse?.mobile ?? "");
      _emailController =
          TextEditingController(text: state.profileResponse?.email ?? "");
      _phoneNumber = PhoneNumber(
        phoneNumber: state.profileResponse?.mobile ?? "",
        isoCode: 'VN',
        dialCode: '+84',
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _initUI(context);
  }

  @override
  Widget builder(BuildContext context, ProfileState state) {
    return AppProgressHUB(
      inAsyncCall: state.inAsyncCall,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          _buildHeaderEditProfile(context, state),
                          SizedBox(
                            height: 32,
                          ),
                          // first name
                          _buildBodyEditProfile(context, state),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
      child: AppbarWidget(
        text: ("edit_profile").tr,
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  Widget _buildHeaderEditProfile(BuildContext context, ProfileState state) {
    return Center(
      child: Stack(
        children: [
          _avatarWidget(state),
          Positioned(
            right: 0.0,
            bottom: 0.0,
            child: GestureDetector(
              onTap: () => bloc.onSelectImageFromDevice(),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.6,
                  ),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(24.0),
                ),
                padding: EdgeInsets.all(6.0),
                child: SvgPicture.asset(
                  Images.edit_icon,
                  height: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyEditProfile(BuildContext context, ProfileState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: Text("first_name".tr)),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: _firstNameController,
          validator: _validations.validateName,
          onSaved: (String value) {
            _firstNameController.text = value;
            bloc.updateFirstName(value);
          },
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(child: Text("last_name".tr)),
        TextFormField(
          keyboardType: TextInputType.name,
          controller: _lastNameController,
          validator: _validations.validateName,
          onSaved: (String value) {
            _lastNameController.text = value;
            bloc.updateLastName(value);
          },
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(child: Text("phone".tr)),
        IgnorePointer(
          ignoring: true,
          child: InternationalPhoneNumberInput(
            selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
            onInputChanged: (value) {
              _phoneNumber = value;
              state.profileRequest.countryCode = _phoneNumber.dialCode;
              state.profileRequest.mobile = _phoneNumber.phoneNumber;
            },
            textFieldController: _mobileController,
            onInputValidated: (isValidate) {},
            initialValue: _phoneNumber,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            inputDecoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              hintText: 'phone'.tr,
            ),
          ),
        ),
        SizedBox(
          height: 16.0,
        ),
        Container(child: Text("email".tr)),
        IgnorePointer(
          ignoring: true,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            validator: _validations.validateEmail,
            onSaved: (String value) {
              _emailController.text = value;
              bloc.updateEmail(value);
            },
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        CustomDefaultButton(
          text: "update".tr,
          press: () {
            _handleUpdate(context, state);
          },
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget _imgNull(BuildContext context, ProfileState state) {
    final _avatar = IMG_URL + (state.profileResponse?.avatar ?? '');
    final _size = 72.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(_size),
      child: CachedNetworkImage(
        imageUrl: _avatar,
        errorWidget: (context, url, error) {
          return Image.asset(Images.defaultAvatar);
        },
        width: _size,
        height: _size,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _avatarWidget(ProfileState state) {
    final _localImage = state.profileRequest.avatar;
    final _avatarUrl = state.profileResponse?.avatar ?? '';
    Widget _avatarContent = Image.asset(
      Images.defaultAvatar,
      height: 72.0,
      width: 72.0,
      fit: BoxFit.cover,
    );

    if (_localImage != null) {
      _avatarContent = Image.file(
        _localImage,
        height: 72.0,
        width: 72.0,
        fit: BoxFit.cover,
      );
    } else if (_avatarUrl.isNotEmpty) {
      _avatarContent = CachedNetworkImage(
        imageUrl: IMG_URL + _avatarUrl,
        width: 72.0,
        height: 72.0,
        fit: BoxFit.cover,
      );
    }
    return ClipRRect(
        borderRadius: BorderRadius.circular(80.0), child: _avatarContent);
  }
}

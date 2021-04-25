import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/common/launch_url.dart';
import 'package:glinkwok_provider/src/common/style.dart';
import 'package:glinkwok_provider/src/components/custom_appbar.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:glinkwok_provider/src/screens/help/cubit/help_cubit.dart';
import 'package:glinkwok_provider/src/widgets/app_progress_hub.dart';
import 'package:simplest/simplest.dart';

class HelpScreen extends CubitWidget<HelpCubit, HelpState> {
  static provider() {
    return BlocProvider(
      create: (_) => HelpCubit(),
      child: HelpScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getHelp();
  }

  @override
  Widget builder(BuildContext context, state) {
    return AppProgressHUB(
      inAsyncCall: state.isLoading,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context, state),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return PreferredSize(
      child: AppbarWidget(
        text: "help".tr,
      ),
      preferredSize: Size.fromHeight(AppBar().preferredSize.height),
    );
  }

  Widget _buildBody(BuildContext context, HelpState state) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "support".tr,
                style: title,
              ),
              SizedBox(
                height: 24,
              ),
              _buildHelpOptions(context, state),
              SizedBox(
                height: 24,
              ),
              Text(
                "our_team_persons_will_contact_you_soon".tr,
                style: body1.apply(color: primaryColor),
              ),
            ],
          ),
        ));
  }

  Widget _buildHelpOptions(BuildContext context, HelpState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // phone
        _buildButton(
          icon: FontAwesomeIcons.phone,
          color: Colors.green,
          onTap: () =>
              bloc.launchUrl(state.helpResponse.contactNumber, UrlScheme.phone),
        ),
        SizedBox(
          width: 24,
        ),

        // email
        _buildButton(
          icon: FontAwesomeIcons.envelope,
          color: Colors.indigo,
          onTap: () =>
              bloc.launchUrl(state.helpResponse.contactEmail, UrlScheme.email),
        ),
        SizedBox(
          width: 24,
        ),

        // website
        _buildButton(
          icon: FontAwesomeIcons.globe,
          color: Colors.blueGrey,
          onTap: () => bloc.launchUrl(BASE_URL, UrlScheme.browser),
        ),
      ],
    );
  }

  Widget _buildButton({IconData icon, Color color, Function onTap}) {
    return PhysicalModel(
        color: Colors.transparent,
        borderRadius: new BorderRadius.circular(50.0),
        child: new InkWell(
          splashColor: splashColor,
          borderRadius: BorderRadius.circular(50.0),
          onTap: onTap,
          child: Container(
            width: 64.0,
            height: 64.0,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(50.0),
              border: new Border.all(
                width: 2.0,
                color: color,
              ),
            ),
            child: Center(
                child: FaIcon(
              icon,
              color: color,
              size: 24,
            )),
          ),
        ));
  }
}

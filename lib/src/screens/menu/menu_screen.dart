import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glinkwok_provider/src/common/config.dart';
import 'package:glinkwok_provider/src/screens/home/cubit/home_cubit.dart';
import 'package:glinkwok_provider/src/screens/menu/cubit/menu_cubit.dart';
import 'package:glinkwok_provider/src/screens/menu/widgets/menu_header_widget.dart';
import 'package:glinkwok_provider/src/screens/menu/widgets/menu_item_widget.dart';
import 'package:simplest/simplest.dart';

import 'menu_item_model.dart';

class MenuScreen extends CubitWidget<MenuCubit, MenuState> {
  static provider() {
    return BlocProvider(
      create: (_) => MenuCubit(),
      child: MenuScreen(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    bloc.getProfile();
  }

  @override
  Widget builder(BuildContext context, MenuState state) {
    return Drawer(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          child: ListView.separated(
              itemBuilder: (_, index) => _buildMenuItem(index),
              separatorBuilder: (_, index) => Divider(
                    height: 1.0,
                    color: Colors.black.withOpacity(0.1),
                  ),
              itemCount: MenuItemType.values.length),
        ),
      ),
    );
  }

  Widget _buildMenuItem(int index) {
    final type = MenuItemType.values[index];
    // Hide card menu at this time
    if (type == MenuItemType.card) {
      return SizedBox.shrink();
    }

    return InkWell(
        onTap: () => context.bloc<HomeCubit>().selectMenuItem(type),
        child: _layoutForItem(type));
  }

  Widget _layoutForItem(MenuItemType type) {
    final user = context.bloc<MenuCubit>().state.profileResponse;
    final _avatar = user?.avatar ?? '';
    switch (type) {
      case MenuItemType.header:
        return Container(
          height: 100,
          child: Center(
            child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: user.id == null
                    ? SpinKitFadingCube(
                        color: primaryColor,
                        size: 40,
                      )
                    : MenuHeaderWidget(
                        imageUrl: IMG_URL + _avatar,
                        title: "${user.firstName} ${user.lastName}",
                        subtitle: "${user.email}",
                      )),
          ),
        );
      case MenuItemType.yourServices:
        return MenuItemWidget(
          icon: FontAwesomeIcons.tasks,
          title: 'services'.tr,
        );
      case MenuItemType.wallet:
        return MenuItemWidget(
          icon: FontAwesomeIcons.wallet,
          title: 'wallet'.tr,
        );
      case MenuItemType.summary:
        return MenuItemWidget(
          icon: FontAwesomeIcons.calculator,
          title: 'summary'.tr,
        );
      case MenuItemType.earning:
        return MenuItemWidget(
          icon: FontAwesomeIcons.moneyBillWave,
          title: 'earning'.tr,
        );
      case MenuItemType.card:
        return MenuItemWidget(
          icon: FontAwesomeIcons.creditCard,
          title: 'card'.tr,
        );
      case MenuItemType.settings:
        return MenuItemWidget(
          icon: FontAwesomeIcons.tools,
          title: 'settings'.tr,
        );
      case MenuItemType.languages:
        return MenuItemWidget(
          icon: FontAwesomeIcons.flag,
          title: 'languages'.tr,
        );
      case MenuItemType.notification:
        return MenuItemWidget(
          icon: FontAwesomeIcons.bell,
          title: 'notification'.tr,
        );
      case MenuItemType.share:
        return MenuItemWidget(
          icon: FontAwesomeIcons.share,
          title: 'share'.tr,
        );
      case MenuItemType.help:
        return MenuItemWidget(
          icon: FontAwesomeIcons.question,
          title: 'help'.tr,
        );
      case MenuItemType.logout:
        return MenuItemWidget(
          icon: FontAwesomeIcons.signOutAlt,
          title: 'logout'.tr,
        );
      default:
        return SizedBox.shrink();
    }
  }
}

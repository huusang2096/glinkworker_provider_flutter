import 'package:flutter/material.dart';
import 'package:glinkwok_provider/src/screens/card/add_card_screen.dart';
import 'package:glinkwok_provider/src/screens/card/card_screen.dart';
import 'package:glinkwok_provider/src/screens/chat/chat_screen.dart';
import 'package:glinkwok_provider/src/screens/document/document_screen.dart';
import 'package:glinkwok_provider/src/screens/earning/earning_screen.dart';
import 'package:glinkwok_provider/src/screens/forgot_pass/forgot_pass_screen.dart';
import 'package:glinkwok_provider/src/screens/help/help_screen.dart';
import 'package:glinkwok_provider/src/screens/home/home_screen.dart';
import 'package:glinkwok_provider/src/screens/languages/languages_screen.dart';
import 'package:glinkwok_provider/src/screens/notification/notification_screen.dart';
import 'package:glinkwok_provider/src/screens/profile/edit_profile_screen.dart';
import 'package:glinkwok_provider/src/screens/signup/signup_screen.dart';
import 'package:glinkwok_provider/src/screens/summary/summary_screen.dart';
import 'package:glinkwok_provider/src/screens/wallet/wallet_screen.dart';
import 'package:glinkwok_provider/src/screens/your_service/history_request_detail.dart';
import 'package:glinkwok_provider/src/screens/your_service/your_service_screen.dart';

import 'src/screens/login/login_screen.dart';
import 'src/screens/splash/splash_screen.dart';

class AppRoute {
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/signup';
  static const String homeScreen = '/homeScreen';
  static const String forgotScreen = '/forgotScreen';
  static const String documentScreen = '/documentScreen';
  static const String earningScreen = '/earningScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String yourServiceScreen = '/yourServiceScreen';
  static const String historyDetailScreen = '/historyDetailScreen';
  static const String cardScreen = '/cardScreen';
  static const String walletScreen = '/walletScreen';
  static const String languagesScreen = '/languagesScreen';
  static const String helpScreen = '/helpScreen';
  static const String summaryScreen = '/summaryScreen';
  static const String addCardScreen = '/addCardScreen';
  static const String chatScreen = '/chatScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final agrs = settings.arguments as Map<String, dynamic> ?? {};
    switch (settings.name) {
      case '/':
      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen.provider());
      case loginScreen:
        return MaterialPageRoute(
            builder: (context) => LoginScreen.provider(), settings: settings);
      case homeScreen:
        return MaterialPageRoute(
            builder: (_) => HomeScreen.provider(), settings: settings);
      case signUpScreen:
        return MaterialPageRoute(
            builder: (context) => SignupScreen.provider(context),
            settings: settings);
      case forgotScreen:
        return _buildProvider(ForgotPassScreen.provider(), settings);
      case documentScreen:
        return _buildProvider(DocumentScreen.provider(), settings);
      case earningScreen:
        return _buildProvider(EarningScreen.provider(), settings);
      case notificationScreen:
        return _buildProvider(NotificationScreen.provider(), settings);
      case editProfileScreen:
        return _buildProvider(EditProfileScreen.provider(), settings);
      case yourServiceScreen:
        return _buildProvider(YourServiceScreen.provider(), settings);
      case historyDetailScreen:
        final requestId = agrs['request_id'];
        return _buildProvider(
            HistoryRequestDetailScreen.provider(requestId), settings);
      case cardScreen:
        return _buildProvider(CardScreen.provider(), settings);
      case walletScreen:
        return _buildProvider(WalletScreen.provider(), settings);
      case languagesScreen:
        return _buildProvider(LanguagesScreen.provider(), settings);
      case helpScreen:
        return _buildProvider(HelpScreen.provider(), settings);
      case summaryScreen:
        return _buildProvider(SummaryScreen.provider(), settings);
      case addCardScreen:
        return _buildProvider(AddCardScreen.provider(), settings);
      case chatScreen:
        return _buildProvider(
            ChatScreen.provider(agrs['tripRequest']), settings);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  static MaterialPageRoute _buildProvider(
      Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}

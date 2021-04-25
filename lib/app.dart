import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as transitionsType;
import 'package:glinkwok_provider/generated/locales.g.dart';
import 'package:glinkwok_provider/src/common/storage/app_prefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';

import 'locator.dart';
import 'routes.dart';
import 'src/common/config.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        /// Auto hide keyboard while clicking outside
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetMaterialApp(
        locale: supportedLocales.firstWhere(
            (locate) => locate.languageCode == locator<AppPref>().langCode),
        supportedLocales: supportedLocales,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        fallbackLocale: Locale('en'),
        translationsKeys: AppTranslation.translations,
        navigatorKey: locator<NavigationService>().navigatorKey,
        theme: _buildThemeData(context),
        title: kAppName,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute.generateRoute,
        defaultTransition: transitionsType.Transition.fade,
      ),
    );
  }

  ThemeData _buildThemeData(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.white, iconTheme: IconThemeData(color: Colors.black)),
        primaryColor: primaryColor,
        primaryTextTheme:
            GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme));
  }
}

import 'package:url_launcher/url_launcher.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

enum UrlScheme {
  browser,
  email,
  phone,
  sms,
}

Future<void> launchURL(String path, UrlScheme urlScheme) async {
  String urlString;
  switch (urlScheme) {
    case UrlScheme.browser:
      urlString = Uri.encodeFull(path);
      break;

    case UrlScheme.email:
      urlString = Uri(
        scheme: 'mailto',
        path: path,
        queryParameters: {
          'subject': "subject_support_email".tr,
        }
      ).toString();
      break;

    case UrlScheme.phone:
      urlString = Uri(
        scheme: 'tel',
        path: path,
      ).toString();
      break;

    default:
  }
  
  if (await canLaunch(urlString)) {
    final bool nativeAppLaunchSucceeded = await launch(
      urlString,
      forceSafariVC: false,
      forceWebView: false,
      universalLinksOnly: true,
    );
    if (!nativeAppLaunchSucceeded) {
      await launch(
        urlString,
        forceSafariVC: true,
      );
    }
  } else {
    print(urlString);
    throw 'Could not launch $urlString';
  }
  
}
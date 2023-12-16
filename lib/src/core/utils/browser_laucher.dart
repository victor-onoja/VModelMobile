import 'package:url_launcher/url_launcher_string.dart';

class VUtilsBrowserLaucher {
  static void lauchWebBrowserWithUrl(String url) async {
    launchUrlString("https://$url");
  }
}

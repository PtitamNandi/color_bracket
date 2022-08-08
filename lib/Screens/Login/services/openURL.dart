import 'package:url_launcher/url_launcher.dart';

class OpenURL{
   launchURLApp(url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(
      uri,
    )) {
      await launchUrl(
        uri,
      );
    } else {
      throw 'Could not launch $uri';
    }
  }
}
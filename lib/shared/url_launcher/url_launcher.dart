import 'package:url_launcher/url_launcher.dart';

launchURL(urlLink) async {
  var url = urlLink;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

adaptivePadding(double screenWidth) {
  if (screenWidth > 1200) {
    return 225;
  } else if (screenWidth > 850) {
    return 100;
  } else {
    return 25;
  }
}

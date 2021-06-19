import 'package:url_launcher/url_launcher.dart';


  launchURLF() async {
    const url = 'https://www.facebook.com/FitandFresh.eg';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }launchURLI() async {
    const url = 'https://www.instagram.com/fitandfresh.eg/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

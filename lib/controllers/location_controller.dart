// import 'package:url_launcher/url_launcher_string.dart';
//
// final String address = "203-20/ hi-tech city Hyderabad";
// final String mapsUrl = 'https://www.google.com/maps/search/?api=1&query=203-20%2F+hi-tech+city+Hyderabad';
//
// void _openMap() async {
//   if (await canLaunchUrlString(mapsUrl)) {
//     await launchUrlString(mapsUrl);
//   } else {
//     throw 'Could not launch $mapsUrl';
//   }
// }

import 'package:url_launcher/url_launcher_string.dart';

const String address = "203-20/ hi-tech city Hyderabad";
const String mapsUrl =
    'https://www.google.com/maps/search/?api=1&query=203-20%2F+hi-tech+city+Hyderabad';

void openMap() async {
  if (await canLaunchUrlString(mapsUrl)) {
    await launchUrlString(mapsUrl);
  } else {
    throw 'Could not launch $mapsUrl';
  }
}

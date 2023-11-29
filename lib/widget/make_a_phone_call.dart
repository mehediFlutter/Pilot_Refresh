import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MakeAPhoneCall extends StatelessWidget {
  const MakeAPhoneCall({
    super.key,
    required this.phone,
  });

  final String phone;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          final url = Uri(scheme: 'tel', path: phone);
          if (await canLaunchUrl(url)) {
            launchUrl(url);
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.dialer_sip),
            SizedBox(
              width: 20,
            ),
            Text("Make A Phone Call"),
          ],
        ));
  }
}

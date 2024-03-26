import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ShareImageAndText extends StatefulWidget {
  final String  imageNameForShare;
  final VoidCallback onPressed;
   ShareImageAndText({super.key, required this.imageNameForShare, required this.onPressed});

  @override
  State<ShareImageAndText> createState() => _ShareImageAndTextState();
}

class _ShareImageAndTextState extends State<ShareImageAndText> {

 Future  shareImageandText() async {
      final urlForImage =
     "https://pilotbazar.com/storage/vehicles/${widget.imageNameForShare.toString()}";
    final uri = Uri.parse(urlForImage);
    final response = await http.get(uri);
    final imageBytes = response.bodyBytes;
    final tempDirectory = await getTemporaryDirectory();
    final tempFile =
        await File('${tempDirectory.path}/sharedImage.jpg').create();
    await tempFile.writeAsBytes(imageBytes);

    final image = XFile(tempFile.path);
    await Share.shareXFiles([image], text: "jsflskjflsjdf");
  }

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
        onPressed: shareImageandText,
        icon: Icon(Icons.share),
        label: Text("SHARE"),
      );
    
  }}
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UploadMultiPleImage extends StatefulWidget {
  final int? newLyAddedCarId;
  const UploadMultiPleImage({super.key, this.newLyAddedCarId});

  @override
  _UploadMultiPleImageState createState() => _UploadMultiPleImageState();
}

class _UploadMultiPleImageState extends State<UploadMultiPleImage> {
  // Use List of XFile to store selected images
  SharedPreferences? prefss;
  List<XFile?> selectedImages = [];
  var resJson;
  Future<void> getImages() async {
    final pickedImages = await ImagePicker().pickMultiImage();
    setState(() {
      selectedImages = pickedImages;
    });
  }

  Future<void> onUploadImages() async {
    prefss = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/vnd.api+json',
      'Authorization': 'Bearer ${prefss?.getString('token')}'
    };
    if (selectedImages.isNotEmpty) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
            "https://pilotbazar.com/api/merchants/vehicles/${widget.newLyAddedCarId}/galleries",
          ),
        );
        request.headers.addAll(headers);
        for (XFile? imageFile in selectedImages) {
          if (imageFile != null) {
            final fileLength = await imageFile.length();

            request.files.add(
              http.MultipartFile(
                'image[]',
                await imageFile.readAsBytes().asStream(),
                fileLength,
                filename: imageFile.name, // Use XFile's name property
              ),
            );
          }
        }
        var response = await request.send();
        final responseData = await response.stream.bytesToString();
        print(responseData);
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Multiple Image Upload'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display picked images (grid view might be suitable)
            if (selectedImages.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: selectedImages
                      .map((imageFile) => Stack(
                            alignment: Alignment.topRight,
                           
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Image.file(
                                  File(imageFile!.path),
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                              IconButton(
                                onPressed: () => _removeImage(imageFile),
                                icon: Icon(Icons.close),
                                color: Colors.white,
                              ),
                            ],
                          ))
                      .toList(),
                ),
              )
            else
              Text(
                'Please Pick Images to Upload',
              ),
            SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: onUploadImages,
                child: Text(
                  "Upload",
                ),
              ),
            ),
            Text(resJson != null ? resJson['message'] : ''),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImages,
        tooltip: 'Pick Images',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  void _removeImage(XFile? imageFile) {
    setState(() {
      selectedImages.remove(imageFile);
    });
  }
}


// request.fields['title'] = jsonEncode({
//   'bn': 'fdfd',
//   'en': 'ds',
// })